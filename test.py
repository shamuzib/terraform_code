import json

def process_permissions(json_data):
    # Load JSON data
    data = json.loads(json_data)

    # Iterate through each user and their permissions
    for user_entry in data:
        username = user_entry["username"]
        permissions = user_entry["permissions"]

        # Iterate through permissions and generate SQL statements
        for dbname, access_rights in permissions.items():
            # Handle wildcard '*' for all databases
            if dbname == "*":
                sql_statement = f"GRANT {', '.join(access_rights)} ON ALL DATABASES TO {username};"
            else:
                sql_statement = f"GRANT {', '.join(access_rights)} ON {dbname} TO {username};"
            print(sql_statement)

# Call the function with the provided JSON data
process_permissions(json_data)
