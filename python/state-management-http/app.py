import logging
import os

import requests
from flask import Flask, jsonify

logging.basicConfig(level=logging.INFO)

base_url = os.getenv('BASE_URL', 'http://localhost') + ':' + os.getenv(
                    'DAPR_HTTP_PORT', '3500')
DAPR_STATE_STORE = 'statestore'

app = Flask(__name__)


@app.route('/')
def index():
    return jsonify({ 'message': 'dapr-python-state-management' })


@app.route('/order/post')
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
        url='%s/v1.0/state/%s' % (base_url, DAPR_STATE_STORE),
        json=state
    )
    logging.info('Saving Order: %s', order)
    post_order_arr.append(order)
    return jsonify({ 'orders': post_order_arr })


@app.route('/order/get')
def get_order():
    get_order_arr = []
    for i in range(1, 10):
        getOrderId = str(i)

    # Get state from a state store
    result = requests.get(
        url='%s/v1.0/state/%s/%s' % (base_url, DAPR_STATE_STORE, getOrderId)
    )
    logging.info('Getting Order: ' + str(result.json()))
    order = 'Getting Order: ' + str(result.json())
    get_order_arr.append(order)
    return jsonify({ 'get_order': get_order_arr })


@app.route('/order/delete/{id}')
def delete_order(id):
    # Delete state from the state store
    result = requests.delete(
        url='%s/v1.0/state/%s' % (base_url, DAPR_STATE_STORE),
        json=id
    )
    logging.info('Deleted Order: %s', result.json())
    deleted_order = 'Deleted Order: %s', result.json()
    return jsonify({ 'deleted_order': deleted_order })
        
