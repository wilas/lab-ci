# -*- coding: utf-8 -*-
from flask import Flask
from blueprint import beer


def create_app(config_filename='app.cfg'):
    app = Flask(__name__)
    app.config.from_pyfile(config_filename)
    app.register_blueprint(beer.beerblue)
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(host='0.0.0.0', port=8000)
