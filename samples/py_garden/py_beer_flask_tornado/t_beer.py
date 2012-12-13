from tornado.wsgi import WSGIContainer
from tornado.httpserver import HTTPServer
from tornado.ioloop import IOLoop

from beer import app

def run(address="127.0.0.1", port=5000):
    http_server = HTTPServer(WSGIContainer(app))
    http_server.listen(port,address)
    IOLoop.instance().start()

if __name__ == "__main__":
    run()
