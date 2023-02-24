import time
import boto3
import hvac
import os

VAULT_ADDR = os.environ['VAULT_ADDR']
VAULT_TOKEN = os.environ['VAULT_TOKEN']
RDS_PROXY_TARGET_GROUP_ARN = os.environ['RDS_PROXY_TARGET_GROUP_ARN']
SECRETS_CHECK_TIMEOUT = int(os.environ.get('SECRETS_CHECK_TIMEOUT', 1800))

def retrieve_new_secrets(event, context):
    riskview = input("Please enter riskview: ")
    qa = input("Please enter qa: ")
    secrets_client = boto3.client('secretsmanager')
    vault_client = hvac.Client(url=VAULT_ADDR, token=VAULT_TOKEN)

    secrets = vault_client.secrets.kv.v2.read_secret_version(
        mount_point='secret',
        path='rds'
    )

    new_secrets = []
    for key, value in secrets['data']['data'].items():
        creation_time = time.mktime(time.strptime(value['created_time'], '%Y-%m-%dT%H:%M:%S.%fZ'))
        current_time = time.time()
        time_diff = current_time - creation_time
        if time_diff <= SECRETS_CHECK_TIMEOUT:
            secret_name_retrieved = key
            secret_name = f"{riskview}-{qa}-rds-{secret_name_retrieved}-secret"
            
            # Check if a secret with the same naming convention already exists in AWS Secrets Manager
            existing_secrets = secrets_client.list_secrets()
            for secret in existing_secrets['SecretList']:
                if secret_name == f"{riskview}-{qa}-rds-{secret_name_retrieved}-secret":
                    raise Exception(f"Secret {secret_name} already exists in AWS Secrets Manager.")
            
            # Create the secret in AWS Secrets Manager
            response = secrets_client.create_secret(
                Name=secret_name,
                SecretString=value['value']
            )
            new_secrets.append(secret_name)
            
    # Update the RDS Proxy target group with the name of the new secrets
    rds_client = boto3.client('rds')
    response = rds_client.modify_db_proxy_target_group(
        DBProxyName=RDS_PROXY_TARGET_GROUP_ARN.split(':')[6],
        TargetGroupName=RDS_PROXY_TARGET_GROUP_ARN.split('/')[-1],
        ConnectionPoolConfig={
            'InitQuery': f"SET @SECRET_NAME='{','.join(new_secrets)}';",
            'SessionPinningFilters': [
                {
                    'Type': 'SECRET_ARN',
                    'Value': f"{secrets_client.meta.endpoint_url}/secretsmanager/*"
                }
            ]
        }
    )

    # Send an email with the names of the new secrets that were created
    if new_secrets:
        send_email(f"The following new secrets were created: {', '.join(new_secrets)}")
