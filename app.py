from flask import Flask, request

app = Flask(__name__)

@app.route('/helloworld', methods=['POST'])
def hello_world():
    name = request.args.get('name')
    return f'Hello {name}'
