import beer


def before_all(context):
    beer.app.config['TESTING'] = True
    context.client = beer.app.test_client()

    # Example:
    # page = context.client.get("/",follow_redirects=True)
    # print page.data


def after_all(context):
    pass
