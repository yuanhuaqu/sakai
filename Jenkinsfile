#!groovy​

node {

  currentBuild.result = "SUCCESS"

  try {

    buildTracsApp();

  } catch(err){
    currentBuild.result = "FAILURE"
    throw err
  } finally {
     // Success or failure, always send notifications
     notifyBuild(currentBuild.result)
  }

}


def buildTracsApp() {
  // stage 'Build'
  //           echo " ==================== "
  //           echo ' BUILD '
  //           echo " ==================== "
  //           echo "Building TRACS from ${params.PERSON}"
  //           echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
  //           sh 'sudo docker run registry.its.txstate.edu/tracs-build:11 -q | sudo docker build -t tracs:nightly-test - '
  // stage 'Push'
  //            echo " ==================== "
  //            echo '   PUSH  '
  //            echo " ==================== "
  //           //  sh 'printenv'
  //            echo 'Prepare for pushing docker image'
  //            sh 'sudo docker tag tracs:nightly-test registry.its.txstate.edu/tracs:nightly-test'
  //            timeout(time: 3, unit: 'MINUTES') {
  //                retry(5) {
  //                    echo 'pushing again!'
  //                    sh 'sudo docker push registry.its.txstate.edu/tracs:nightly-test'
  //                }
  //            }
  stage  'Clean'
             echo " ==================== "
             echo ' CLEAN '
             echo " ==================== "
             echo '   Clean up previous deployment  '
             sh '''#!/bin/bash -l
                  . /usr/share/jenkins/resty
                  resty http://147.26.118.230:3000/v1 -H "Content-type: application/json"
                  GET /services/
              '''
             echo 'Stop and delete container'
             try {
               sh 'resty'
               sh 'DELETE /services/tracstomcat/containers/echo'
             } catch(e){
               exit 0;
             }

             echo 'Remove old docker image'
             sh 'DELETE /services/tracstomcat/images/registry.its.txstate.edu/tracs:nightly-test'
             sh 'sleep 10'
  stage 'Deploy'
             echo " ==================== "
             echo '   DEPLOY   '
             echo " ==================== "
             echo 'Getting new build from registry'
             retry(5) {
                 sh 'POST /services/tracstomcat/images/pull \'{"image":"registry.its.txstate.edu/tracs:nightly-test"}\''
                 sh 'sleep 10'
             }

             timeout(time:3, unit:'MINUTES') {
                 sh 'echo taking too long'
             }
  stage 'Start'
            echo " ==================== "
            echo '   START  '
            echo " ==================== "
            echo "tarting tracs container "
            retry(5) {
                sh 'GET /services/tracstomcat/images/registry.its.txstate.edu/tracs:nightly-test'
                sh 'sleep 10'
            }

            timeout(time:3, unit:'MINUTES') {
                sh 'echo taking too long, no image for tracs'
            }
            echo 'Creating and starting a docker container'
            sh 'POST /services/tracstomcat/containers \'{"name": "echo", "config": "default", "image": "registry.its.txstate.edu/tracs:nightly-test", "database": "sakaidb"}\''
}

def notifyBuild(String buildStatus = 'STARTED') {
   // build status of null means successful
   buildStatus =  buildStatus ?: 'SUCCESSFUL'

   // Default values
   def colorName = 'RED'
   def colorCode = '#FF0000'
   def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
   def summary = "${subject} (${env.BUILD_URL})"
   def content = '${JELLY_SCRIPT,template="static-analysis"}'
  //  def content = '${JELLY_SCRIPT,template="html"}'

  //  def content ="""<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
  //  <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>"""

   // Override default values based on build status
   if (buildStatus == 'STARTED') {
     color = 'YELLOW'
     colorCode = '#FFFF00'
   } else if (buildStatus == 'SUCCESSFUL') {
     color = 'GREEN'
     colorCode = '#00FF00'
   } else {
     color = 'RED'
     colorCode = '#FF0000'
   }

   // Send notifications
   //slackSend (color: colorCode, message: summary)

   emailext (
       subject: subject,
       body: content,
       mimeType: 'text/html',
       attachLog: true,
       recipientProviders: [[$class: 'DevelopersRecipientProvider'],[$class: 'RequesterRecipientProvider']]
    )
}
