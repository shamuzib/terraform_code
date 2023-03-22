import requests

# Set up API endpoint URL and API key
url = 'https://<PMP_Endpoint_URL>/restapi'
api_key = '<your_API_key>'

# Set up HTTP headers for API requests
headers = {
    'Authorization': 'APIKEY ' + api_key,
    'Content-Type': 'application/json'
}

# Send API request to retrieve all resource groups
endpoint = url + '/resgrps'
response = requests.get(endpoint, headers=headers)

# Process API response
if response.status_code == 200:
    # Successful API request
    data = response.json()
    # Print the list of resource groups
    for resgrp in data['resgrp']:
        print(resgrp['resgrp_name'])
else:
    # Failed API request
    print('Error:', response.status_code, response.text)
