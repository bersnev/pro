pipeline {
    agent { 
        label 'master'
    }
    environment {
        registry = 'bersnev/project'
        registryCredential = 'dockerhub'
        params.build_and_run_docker = true
        params.remove = true
    }
  stages {
     stage ('Build and run docker for Dokuwiki') {
	    when {
	     expression {params.build_and_run_docker == true}
	    }  
	      stages {
          stage('Clone Git') {
            steps {
              git url: "git@github.com:bersnev/pro.git}",
              credentialsId: 'secret'
            }
          }
          stage('Build image') {
            steps {
              script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
              }
            }
          }	          
          stage('Push image') {
            steps {
              script {
                docker.withRegistry( '', registryCredential ) {
                  dockerImage.push()
                }
              }
            }
          }
          stage('Run docker image'){
            steps {
              sh "echo $registry:$BUILD_NUMBER"
              sh "docker run -d  -p 9001:80 --name dokuwiki $registry:$BUILD_NUMBER"
            }
          } 
	    }
     }
     stage('Remove Dokuwiki') {
	    when {
	     expression {params.remove == true}
	    }
        stages {
		  stage('Stop and delete docker container') {
		    steps {
                sh "docker container stop dokuwiki"
			    sh "docker container prune -f"
	        }
		  }
          stage('Remove docker image') {
            steps{
              sh "docker system prune -af"
            }
          }
        }
     }		
   }
   post {
    success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      }
    failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      }
    }
}



