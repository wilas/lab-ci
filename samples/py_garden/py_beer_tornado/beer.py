import os
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.options
try:
    import simplejson as json
except ImportError:
    import json

tornado.options.define("beer_json", default="beerpoint.json", 
        help="Json file with beerpoint description")

class BeerHandler(tornado.web.RequestHandler):
    def get(self):
        with open(tornado.options.options.beer_json,'r') as file:
            gbeer = json.load(file)
        name = gbeer['name']
        beers = gbeer['box']
        beer_styles = beers.keys()
        self.render("t_beerpoint.html", name=name, beer_styles=beer_styles, beers=beers)

def run(address='127.0.0.1',port=5000):
    handlers = [
        (r"/", BeerHandler),
    ]
    settings = dict(
        template_path=os.path.join(os.path.dirname(__file__), "templates"),
    )
    app = tornado.web.Application(handlers, **settings)
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(port,address)
    io_loop = tornado.ioloop.IOLoop.instance()
    io_loop.start()

if __name__ == "__main__":
    run(address='0.0.0.0', port=8000)
