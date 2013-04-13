class jvm {

    # java 1.7.0 not working yet good with jenkins
    package { 'java':
        ensure => installed,
        name   => ['java-1.6.0-openjdk', 'java-1.6.0-openjdk-devel'],
    }

}
