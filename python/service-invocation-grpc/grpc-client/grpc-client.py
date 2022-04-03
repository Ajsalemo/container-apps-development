import json
import time

from flask import Flask, jsonify
from dapr.clients import DaprClient

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({ 'message': 'dapr-grpc-client' })


@app.route('/api/v1/grpc')
def grpc_client():
    with DaprClient() as d:
        req_data = {
            'id': 1,
            'message': 'hello world'
        }

        while True:
            # Create a typed message with content type and body
            resp = d.invoke_method(
                'grpc-server',
                'my-method',
                data=json.dumps(req_data),
            )

            # Print the response
            print(resp.content_type, flush=True)
            print(resp.text(), flush=True)

            time.sleep(2)
    
            return jsonify({ 'content_type': resp.content_type, 'response': resp.text() })