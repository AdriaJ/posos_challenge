
import os
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import svm
from joblib import load

import numpy as np

from flask import Flask, request, jsonify
app = Flask(__name__)


current_path = os.getcwd()

# Models must be in the current working directory !
vectorizer = load(os.path.join(current_path, "vectorizer"))
clf = load(os.path.join(current_path, "model_svm"))


input = ["risques%20poisson%20cru%20pendant%20la%20grossesse%20%3F"]

def classify(input):
    input_v = vectorizer.transform(input)
    pred = clf.predict(input_v)
    probas_pred = clf.predict_proba(input_v)
    return {'intent': int(pred[0]),
            'probability': str(probas_pred[0][pred][0])}


@app.route('/')
def index():
    return '<h1> Welcome to my micro service <h1>'

@app.route('/intent', methods=['POST', 'GET'])
def predictions():
    if 'query' in request.args:
        input = [request.args['query']]
        return jsonify(classify(input))
    else:
        return 'Error: No query provided. Please specify a query.'



if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port='4002')


