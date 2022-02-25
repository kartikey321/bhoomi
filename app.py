from concurrent.futures import process
from flask import flask,jsonify,request
import time

app=flask(__name__)
@app.route("/chatbot",method=["POST"])
def response():
    query=dict(request.form)['query']
    result = query+" "+time.ctime
    return jsonify({"response":result})

if __name__=="__main__":
    app.run(host =process.env.PORT)