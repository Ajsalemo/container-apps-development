from flask import Flask, request, jsonify
import json

app = Flask(__name__)


@app.route("/")
def index():
    return jsonify({ "message": "container-apps-development-pub-sub-orderprocessor" })


# Register Dapr pub/sub subscriptions
@app.route('/dapr/subscribe')
def subscribe():
    subscriptions = [{
        'pubsubname': 'ansalemo-eventhub-partition',
        'topic': 'checkout',
        'route': 'api/v1/checkout'
    }]
    print('Dapr pub/sub is subscribed to: ' + json.dumps(subscriptions))
    return jsonify(subscriptions)


# Dapr subscription in /dapr/subscribe sets up this route
@app.route('/api/v1/checkout', methods=['POST'])
def orders_subscriber():
    event_orderid = request.json['data']['orderId']
    print('Subscriber received : ' + json.dumps(event_orderid), flush=True)
    return json.dumps({'success': True}), 200, {
        'ContentType': 'application/json'}