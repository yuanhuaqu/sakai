#!groovy​
pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'which sudo'
                sh 'pwd'
                sh 'sudo docker run registry.its.txstate.edu/tracs-build:11 -q | sudo docker build -t tracs:nightly-test - '
            }
        }
    }
}
