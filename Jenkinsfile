pipeline {
   agent any
    stages {
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
                       sh 'docker-compose up -d'
                   }
               }

    }
}
