import os
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def hello_world():
    keyVaultName = os.environ["KEY_VAULT_NAME"]
    secretName = os.environ["SECRET_NAME"]
    KVUri = f"https://{keyVaultName}.vault.azure.net"

    credential = DefaultAzureCredential()
    client = SecretClient(vault_url=KVUri, credential=credential)

    print(f"Retrieving your secret from {keyVaultName}.")

    retrieved_secret = client.get_secret(secretName)

    print(f"Your secret is '{retrieved_secret.value}'.")
    print("Done.")

    return jsonify({ "message": retrieved_secret.value })