from flask import Flask, request, jsonify
import json

app = Flask(__name__)


@app.route('/')
def index():
    return jsonify({ 'message': 'dapr-python-order-processor-gh-actions' })


@app.route('/orders', methods=['POST'])
def getOrder():
    data = request.json
    print('Order received : ' + json.dumps(data), flush=True)
    return json.dumps({'success': True}), 200, {
        'ContentType': 'application/json'}