import json
import os
import requests

from flask import Flask, jsonify

SERVICE_BASE_URL = os.getenv('BASE_URL', 'http://localhost')
DAPR_HTTP_PORT = os.getenv('DAPR_HTTP_PORT', '3500')
DAPR_APP_ID = os.getenv('DAPR_APP_ID', 'order-processor-app')
DAPR_ENDPOINT_TYPE = 'v1.0/invoke'

base_url = f'{SERVICE_BASE_URL}:{DAPR_HTTP_PORT}/{DAPR_ENDPOINT_TYPE}/{DAPR_APP_ID}/method'

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({ 'message': 'dapr-python-checkout-gh-actions' })


@app.route('/api/v1/orders/post')
def postOrders():
    orderArr = []
    for i in range(1, 11):
        order = {'order_id': i}

        # Invoking a service
        requests.post(
            url=f'{base_url}/orders',
            data=json.dumps(order)
        )

        msg = 'Order passed: ' + json.dumps(order)
        orderArr.append(msg)
        
    return jsonify({ 'orders': orderArr })


