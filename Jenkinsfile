pipeline {
    agent any
    stages {
        stage('Build') {
            tools {
                jdk "JDK 8"
            }
            steps {
                echo 'Running build automation'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        stage('Build Docker Image') {
          when {
            branch 'master'
          }
          steps {
            script {
              app = docker.build("odusseos2017/train-schedule")
              app.inside {
                sh 'echo $(curl localhost:8080)'
              }
            }
          }
        }        
	stage('Push Docker Image') {
	  when {
	    branch 'master'
 	  }
	  steps {
	    script {
	      docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {
	        app.push("${env.BUILD_NUMBER}")
		app.push("latest")
	      }
	    }
	  }
        }
        stage('DeployToProduction') {
          when {
            branch 'master'
          }
          steps {      
            sshPublisher(
              failOnError: true,
              continueOnError: false,
              publishers: [
                sshPublisherDesc(
                  configName: 'Production',
                  verbose: true,
                  transfers: [
                    sshTransfer(
                      execCommand: "docker pull odusseos2017/train-schedule:${env.BUILD_NUMBER} ;
                        docker stop train-schedule ; "
                    )
                  ]
                )
              ]
            )
          }
        }
    }
}
