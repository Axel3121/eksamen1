from flask import Flask, render_template
from db import hentedata

app = Flask (__name__)

@app.route('/')
def hello_world():
    data = hentedata()
    return render_template("flasker.html", flasker = data)

if __name__ == '__main__':
    app.run(debug=True)