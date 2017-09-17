import requests
import json
import sys

query = {}

try:
    query = json.loads(input())
except json.decoder.JSONDecodeError:
    sys.stderr.write("Invalid JSON.\n")
    sys.exit(-1)
except Exception as e:
    sys.stderr.write(e)
    sys.exit(-1)

if not "apikey" in query:
    sys.stderr.write("Digital Ocean API key is required.\n")
    sys.exit(-1)

endpoint = "https://api.digitalocean.com/v2/account/keys"
headers = {"Authorization":"Bearer " + query["apikey"], "Accept": "application/json"}

try:
    response = requests.get(endpoint, headers=headers).json()
    keys = []

    for key in response["ssh_keys"]:
        keys.append(str(key["id"]))

    print(json.dumps({"keys": ",".join(keys)}))
except Exception as e:
    sys.stderr.write(e)
    sys.exit(-1)
