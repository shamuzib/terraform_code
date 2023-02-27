import os
import hvac

def check_vault_sealed():
    # Load Vault server URL from environment variable
    vault_url = os.environ.get('VAULT_URL')
    if not vault_url:
        raise ValueError('Vault URL not set in environment variable "VAULT_URL"')
    
    # Create a new Vault client
    client = hvac.Client(url=vault_url)
    
    # Check if Vault server is sealed
    status = client.sys.is_sealed()
    if status:
        return "Vault is sealed, please unseal the Vault"
    else:
        return "Vault is unsealed"
