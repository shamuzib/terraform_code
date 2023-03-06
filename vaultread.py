import os
import subprocess
import json

VAULT_ADDR = "https://example.com:8200"
VAULT_TOKEN = "s.abc123def456ghi789"
VAULT_PATH = "secret/data/my/path"

# Set environment variables for Vault
os.environ["VAULT_ADDR"] = VAULT_ADDR
os.environ["VAULT_TOKEN"] = VAULT_TOKEN

# Get the JSON output from the Vault path
output = subprocess.check_output(["vault", "read", "-format=json", VAULT_PATH])

# Convert the JSON output to a Python dictionary
data = json.loads(output.decode("utf-8"))

# Print the data dictionary
print(data)
