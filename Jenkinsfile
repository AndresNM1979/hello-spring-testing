pipeline {
   agent any
    stages {
        stage('Test') {
           steps {
                echo 'Testing..'
                sh './gradlew clean test'
                junit 'build/test-results/test/TEST-*.xml'
              }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sh './gradlew assemble'
            }
        }
        stage('Archive'){
            steps{
                echo 'Archivando..'
                archiveArtifacts artifacts: 'build/libs/*.jar'
            }
        }
       stage('Deploying'){
            steps{
                echo 'Se ha archivado el artefacto, desplegando ..'
            //    sh 'docker-compose up -d'
            }
       }

    }
}
