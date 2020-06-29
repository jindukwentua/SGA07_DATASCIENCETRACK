import os
import pandas as pd
import numpy as np
import json
from flask import Flask, render_template, request, abort, jsonify, Response, make_response
import pickle


app = Flask("api")


def response_ok(data):
   response = jsonify({'status': 'success', 'data': data}, 200)
   return make_response(response)


def response_error(message, error=None, error_code=None):
    response = jsonify({'status': 'fail', 'message': message, 'error': error, 'error_code': error_code}, 400)
    return make_response(response)

def check_auth_header():
    username, password = request.authorization.get('username', None), request.authorization.get('password', None)
    if not username or not password:
        return False, "Unable to authenticate user."
    if username != "stuternuser" or password != "stuternpass":
        return False, "Invalid authentication header"
    return True, "Successfully authenticated"


@app.route('/api/v1.0/predict', methods=['POST'])
def predict():
    validate_auth_header = check_auth_header()
    if not validate_auth_header[0]:
       return validate_auth_header[1]
    query=request.json
    X=pd.DataFrame([query])
    print(X)

    model=pickle.load(open('model/classifier.pkl','rb'))
    results = model.predict(X)
    print(results[0])
    return jsonify({"Class":str(results[0])})


    
if __name__ == '__main__':
    app.run()



