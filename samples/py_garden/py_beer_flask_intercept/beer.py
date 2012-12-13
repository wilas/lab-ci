from flask import Flask

def create_app():
    app = Flask(__name__)

    @app.route("/")
    def hello():
        return "<title>Beer Point</title>lager beer:"

    return app

    
if __name__ == "__main__":
    app = create_app()
    app.run()
