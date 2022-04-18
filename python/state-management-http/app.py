import logging
import os

import requests
from flask import Flask, jsonify

SERVICE_BASE_URL = os.getenv('BASE_URL', 'http://localhost') 
DAPR_STATE_STORE = 'statestore'
DAPR_HTTP_PORT = os.getenv('DAPR_HTTP_PORT', '3500')
DAPR_ENDPOINT_TYPE = 'v1.0/state'

base_url = f"{SERVICE_BASE_URL}:{DAPR_HTTP_PORT}/{DAPR_ENDPOINT_TYPE}/{DAPR_STATE_STORE}"

app = Flask(__name__)


@app.route('/')
def index():
    return jsonify({ 'message': 'dapr-python-state-management' })


@app.route('/api/order/post')
def post_order():
    post_order_arr = []
    for i in range(1, 10):
        postOrderId = str(i)
        order = {'postOrderId': postOrderId}
        state = [{
            'key': postOrderId,
            'value': order
        }]

        # Save state into a state store
        requests.post(
            url=base_url,
            json=state
        )
        logging.info('Saving Order: %s', order)
        post_order_arr.append(order)

    return jsonify({ 'orders': post_order_arr })


@app.route('/api/order/get')
def get_order():
    get_order_arr = []
    for i in range(1, 10):
        getOrderId = str(i)

        # Get state from a state store
        result = requests.get(
            url=f'{base_url}/{getOrderId}' 
        )
        logging.info('Getting Order: ' + str(result.json()))
        order = 'Getting Order: ' + str(result.json())
        get_order_arr.append(order)
    return jsonify({ 'get_order': get_order_arr })


@app.route('/api/order/delete/{id}')
def delete_order(id):
    # Delete state from the state store
    result = requests.delete(
        url='%s/v1.0/state/%s' % (base_url, DAPR_STATE_STORE),
        json=id
    )
    logging.info('Deleted Order: %s', result.json())
    deleted_order = 'Deleted Order: %s', result.json()
    return jsonify({ 'deleted_order': deleted_order })
        
