import boto3

def update_rds_proxy_with_secrets(proxy_name, secrets_arn_file):
    # Create an RDS client and retrieve the current proxy details
    rds_client = boto3.client('rds')
    describe_db_proxies_response = rds_client.describe_db_proxies(DBProxyName=proxy_name)
    db_proxy = describe_db_proxies_response['DBProxies'][0]

    # Retrieve the current list of secrets for the proxy
    current_secrets = db_proxy['Auth'][0]['SecretArn'].split(',')

    # Load the secrets ARNs from a file
    with open(secrets_arn_file) as f:
        secrets_arns = f.readlines()

    # Extract the secret ARNs from the file and remove any leading/trailing whitespace
    new_secrets = [arn.strip() for arn in secrets_arns]

    # Check if the secrets list has changed
    if set(current_secrets) == set(new_secrets):
        print(f"No changes detected for RDS Proxy '{proxy_name}'")
        return

    # Append the new secrets to the existing list
    updated_secrets = list(set(current_secrets + new_secrets))

    # Update the RDS Proxy with the updated list of secrets
    modify_db_proxy_response = rds_client.modify_db_proxy(
        DBProxyName=proxy_name,
        Auth=[{'SecretArn': arn} for arn in updated_secrets]
    )

    print(f"Successfully updated RDS Proxy '{proxy_name}' with new secrets list")
