import json
import os

import requests
from flask import Flask, jsonify

SERVICE_BASE_URL = os.getenv('BASE_URL', 'http://localhost')
DAPR_HTTP_PORT = os.getenv('DAPR_HTTP_PORT', '3500')
DAPR_APP_ID = os.getenv('DAPR_APP_ID', 'order-processor-app')

base_url = f'{SERVICE_BASE_URL}:{DAPR_HTTP_PORT}/v1.0/invoke/{DAPR_APP_ID}/method'

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({ 'message': 'dapr-python-checkout' })


@app.route('/post_orders')
def postOrders():
    print(base_url)
    orderArr = []
    for i in range(1, 11):
        order = {'order_id': i}

        # Invoking a service
        result = requests.post(
            url=f'{base_url}/orders',
            data=json.dumps(order)
        )

        print(result)
        msg = 'Order passed: ' + json.dumps(order)
        print(msg)
        orderArr.append(msg)

    return jsonify({ 'orders': orderArr })


