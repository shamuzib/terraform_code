import hvac
import os

def lambda_handler(event, context):
    # Create a Hashicorp Vault client object
    client = hvac.Client(url=os.environ['VAULT_URL'])

    # Check if the Vault server is sealed
    if client.is_sealed():
        # Vault is sealed, return an error message
        return {
            'statusCode': 500,
            'body': 'Vault is sealed, please unseal the vault first'
        }
    else:
        # Vault is not sealed, return a success message
        return {
            'statusCode': 200,
            'body': 'Vault is not sealed, ready to use'
        }
