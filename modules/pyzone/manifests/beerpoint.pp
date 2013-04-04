class pyzone::beerpoint {

    # apps
    package { 
        "Flask": 
            ensure     => "0.9",
            provider   => pip;
        "tornado": 
            ensure     => "2.4.1",
            provider   => pip;
        "simplejson": 
            ensure     => "3.0.5",
            provider   => pip;
    }

    # tests
    package { 
        "behave":
            ensure     => "1.2.2",
            provider   => pip;
        "nose":
            ensure     => "1.2.1",
            provider   => pip;
        "coverage":
            ensure     => "3.6b3",
            provider   => pip;
    }

    # tests support
    package {
        "wsgi-intercept": #intercept
            ensure     => "0.5.1",
            provider   => pip;
        "mechanize": #intercept
            ensure     => "0.2.5",
            provider   => pip;
        "selenium": #selenium, tornado
            ensure     => "2.28.0",
            provider   => pip;
        "twill": #twill
            ensure     => "0.9",
            provider   => pip;
        "BeautifulSoup": #all
            ensure     => "3.2.1",
            provider   => pip;
    }

    # selenium need X to open webbrowser
    # use `ssh -X root@host` to enables X11 forwarding
    package { ["firefox", "xorg-x11-xauth"]:
        ensure => installed,
    }
}

