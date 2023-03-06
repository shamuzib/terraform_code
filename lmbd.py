import json
import requests

def lambda_handler(event, context):
    vault_url = event.get("vault_url")
    if not vault_url:
        return {"statusCode": 400, "body": "Missing 'vault_url' parameter"}

    try:
        sealed = is_vault_sealed(vault_url)
        return {"statusCode": 200, "body": json.dumps({"sealed": sealed})}
    except Exception as e:
        return {"statusCode": 500, "body": str(e)}

def is_vault_sealed(vault_url):
    """
    Check if a Vault server at the given URL is sealed or not.
    Returns True if the server is sealed, False otherwise.
    """
    api_url = f"{vault_url}/v1/sys/seal-status"
    response = requests.get(api_url)
    if response.status_code == 200:
        data = response.json()
        return data["sealed"]
    else:
        raise Exception(f"Error checking Vault seal status: {response.status_code} - {response.text}")
