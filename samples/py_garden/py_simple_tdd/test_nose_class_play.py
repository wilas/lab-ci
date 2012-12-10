class TestPlay:

    @classmethod
    def setup_class(cls):
        """This method is run once for each class before any tests are run"""
        cls.soup = 100
        cls.pasta = 100

    @classmethod
    def teardown_class(cls):
        """This method is run once for each class _after_ all tests are run"""
        cls.soup = 0
        cls.pasta = 0

    def setUp(self):
        """This method is run once before _each_ test method is executed"""    
        self.__class__.soup += 1
        self.pasta += 1

    def teardown(self):
        """This method is run once after _each_ test method is executed"""
        print "\nsoup = ", self.soup
        print "pasta = ", self.pasta
    

    def test_1(self):
        pass
    
    def test_2(self):
        pass
    
    def test_3(self):
        pass
