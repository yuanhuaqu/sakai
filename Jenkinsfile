#!groovy​
pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'which sudo'
                sh 'pwd'
                sh 'sudo docker tag tracs:nightly-test registry.its.txstate.edu/tracs:nightly-test'
            }
        }
    }
}
