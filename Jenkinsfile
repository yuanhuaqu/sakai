#!groovy​
pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'which sudo'
                sh 'pwd'
                sh 'sudo docker tag hello-world registry.its.txstate.edu/hello-world'
                sh 'sudo docker push registry.its.txstate.edu/hello-world'

            }
        }
    }
}
