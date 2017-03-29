#!groovy​
pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'which sudo'
                sh 'pwd'
                sh 'whoami'
                sh 'source /usr/share/jenkins/resty'
                sh 'resty http://147.26.118.230:3000/v1 -H \'Content-type: application/json\''
                sh 'GET /services'
                sh 'POST /services/tracsdb/images/pull \'{"image":"registry.its.txstate.edu/mysql-server:5.6"}\''

            }
        }
    }
}
