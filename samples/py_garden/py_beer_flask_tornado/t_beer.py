import tornado.wsgi
import tornado.httpserver
import tornado.ioloop

import beer

app = beer.app

def run(address="127.0.0.1", port=5000):
    application = tornado.wsgi.WSGIContainer(app)
    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(port,address)
    tornado.ioloop.IOLoop.instance().start()

if __name__ == "__main__":
    run()
