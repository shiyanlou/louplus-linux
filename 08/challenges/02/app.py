from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
    """
    网站根页面
    """

    return 'Welcome to Shiyanlou!'
