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

    
import subprocess

def check_vault(vault_url, vault_token, secret_path):
    # Check if Vault server is sealed
    sealed = subprocess.run(['vault', 'status', '-format=json'], capture_output=True)
    if sealed.returncode != 0:
        raise RuntimeError('Error checking Vault status')
    
    sealed_json = json.loads(sealed.stdout)
    if sealed_json['sealed']:
        return "Vault is sealed, please unseal the Vault"
    
    # Check if secret path exists
    path_exists = subprocess.run(['vault', 'kv', 'get', '-format=json', secret_path], 
                                 env={'VAULT_ADDR': vault_url, 'VAULT_TOKEN': vault_token},
                                 capture_output=True)
    
    if path_exists.returncode == 0:
        # Path exists, read and display output
        secret_value = json.loads(path_exists.stdout)['data']['data']
        return f"Secret value for path {secret_path}: {secret_value}"
    else:
        # Path does not exist
        return f"Path {secret_path} does not exist"
 
==========================================================================================================
    
import subprocess

def check_vault(vault_url, vault_token, secret_path):
    # Check Vault status
    status = subprocess.run(['vault', 'status'], 
                            env={'VAULT_ADDR': vault_url, 'VAULT_TOKEN': vault_token},
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    
    if status.returncode == 0:
        # Vault is unsealed, check if secret path exists
        path_exists = subprocess.run(['vault', 'kv', 'get', '-format=json', secret_path], 
                                     env={'VAULT_ADDR': vault_url, 'VAULT_TOKEN': vault_token},
                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        
        if path_exists.returncode == 0:
            # Path exists, read and display output
            secret_value = path_exists.stdout.decode('utf-8').split('\n')[1]
            return f"Secret value for path {secret_path}: {secret_value}"
        else:
            # Path does not exist
            return f"Path {secret_path} does not exist"
    else:
        # Vault is sealed
        raise RuntimeError('Error checking Vault status')

