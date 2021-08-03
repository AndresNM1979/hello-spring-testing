pipeline {
   agent any
    stages {
        stage('Test') {
           steps {
                echo 'Testing..'
                withGradle {
                    sh './gradlew clean test'
                }
           }
           post {
                always {
                    junit 'build/test-results/test/TEST-*.xml'
                    jacoco.execPattern:'build/jacoco/*.exec'
                }
           }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sh './gradlew assemble'
               //****SE PODRIA GENERAR UN CONTENEDOR****
               // sh 'docker-compose build'
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
