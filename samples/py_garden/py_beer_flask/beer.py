# -*- coding: utf-8 -*-
from flask import Flask
from flask import render_template, json, g

DEBUG = True
BEER_JSON = 'beerpoint.json'

app = Flask(__name__)
app.config.from_object(__name__)


@app.route('/')
def hello():
    name = g.beer['name']
    beers = g.beer['box']
    beer_styles = beers.keys()
    return render_template('beerpoint.html', name=name, beer_styles=beer_styles, beers=beers)

@app.before_request
def before_request():
    with open(app.config['BEER_JSON'],'r') as file:
        g.beer = json.load(file)
    file.close()

if __name__ == '__main__':
    app.run()
