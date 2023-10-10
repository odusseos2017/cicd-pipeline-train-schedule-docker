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
    }
}
