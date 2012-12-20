from flask import Blueprint, current_app, render_template, json, g

beerblue = Blueprint('blueprint', __name__, template_folder='templates')

@beerblue.route('/')
def hello():
    name = g.beer['name']
    beers = g.beer['box']
    beer_styles = beers.keys()
    return render_template('beerpoint.html', name=name, beer_styles=beer_styles, beers=beers)

@beerblue.before_request
def before_request():
    with open(current_app.config['BEER_JSON'],'r') as file:
        g.beer = json.load(file)
    file.close()
