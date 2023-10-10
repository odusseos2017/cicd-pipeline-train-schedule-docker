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
    }
}
