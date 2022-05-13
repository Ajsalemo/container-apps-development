import json
import logging
import requests

from flask import Flask, jsonify

app = Flask(__name__)

logging.basicConfig(level=logging.INFO)

base_url = 'http://localhost:3500'
PUBSUB_NAME = 'orderpubsub'
TOPIC = 'orders'

logging.info('Publishing to baseURL: %s, Pubsub Name: %s, Topic: %s' % (
            base_url, PUBSUB_NAME, TOPIC))


@app.route("/")
def index():
    return jsonify({ "message": "container-apps-development-pub-sub" })


@app.route("/api/v1/pubsub")
def pubsub():
    pubsub_arr = []
    for i in range(1, 10):
        order = {'orderId': i}

        # Publish an event/message using Dapr PubSub via HTTP Post
        requests.post(
            url='%s/v1.0/publish/%s/%s' % (base_url, PUBSUB_NAME, TOPIC),
            json=order
        )
        logging.info('Published data: ' + json.dumps(order))

        msg = 'Data passed: ' + json.dumps(order)
        pubsub_arr.append(msg)

    return jsonify({ 'orders': pubsub_arr })
