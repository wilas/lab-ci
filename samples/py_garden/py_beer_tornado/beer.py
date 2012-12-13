import tornado.httpserver
import tornado.ioloop
import tornado.web


class BeerHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("<title>Beer Point</title>lager beer:")


def run(address='127.0.0.1',port=5000):
    app = tornado.web.Application([
        (r"/", BeerHandler),
    ])
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(port,address)
    tornado.ioloop.IOLoop.instance().start()


if __name__ == "__main__":
    run()
