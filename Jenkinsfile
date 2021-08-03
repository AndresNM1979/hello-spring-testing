#!/usr/bin/env groovy
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
                    jacoco execPattern:'build/jacoco/*.exec'

                }
           }
        }
        //stage de calidad de servicio
        stage('QA') {
            steps {
              withGradle {
                  sh './gradlew check'
              }
            }
            post {
                 always {
                      recordIssues(
                          tools: [
                              pmdParser(pattern: 'build/reports/pmd/+.xml'),
                              spotBugs(pattern: 'build/reports/spotbugs/+.xml')
                          ]
                      )
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
