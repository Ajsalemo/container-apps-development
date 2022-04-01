import json
import logging
import os
import time

import requests
from flask import Flask, jsonify

SERVICE_BASE_URL = os.getenv('BASE_URL', 'http://localhost')
DAPR_HTTP_PORT = os.getenv('DAPR_HTTP_PORT', '3500')
DAPR_APP_ID = os.getenv('DAPR_APP_ID', 'order-processor')

base_url = f'{SERVICE_BASE_URL}:{DAPR_HTTP_PORT}'

# Adding app id as part of the header
headers = {'dapr-app-id': DAPR_APP_ID}

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({ 'message': 'dapr-service-invocation' })


@app.route('/post_orders')
def postOrders():
    print(base_url)
    for i in range(1, 11):
        order = {'orderId': i}
        orderArr = []

        # Invoking a service
        result = requests.post(
            url=f'{base_url}/orders',
            data=json.dumps(order),
            headers=headers
        )

        print(result)
        msg = 'Order passed: ' + json.dumps(order)
        print(msg)
        orderArr.append(msg)

    return jsonify({ 'orders': orderArr })


