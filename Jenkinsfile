#!groovy​
pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'which sudo'
                sudo docker run registry.its.txstate.edu/tracs-build:11 | sudo docker build -t tracs:nightly-test -
            }
        }
    }
}
