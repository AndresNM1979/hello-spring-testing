#!/usr/bin/env groovy
import java.util.concurrent.CompletionStage

pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                echo 'Testing..'
                withGradle {
                    sh './gradlew clean test pitest'
                }
            }
            post {
                always {
                    junit 'build/test-results/test/TEST-*.xml'
                    jacoco execPattern: 'build/jacoco/*.exec'
                    recordIssues(enabledForFailure: true, tool: pit(pattern: "build/reports/pitest/**/*.xml"))

                }
            }
        }
        stage('Analysis') {
            parallel {
                stage('SonarQube Analysis') {
                    when { expression { true } }
                    steps {
                        withSonarQubeEnv('SonarQube') {
                            sh "./gradlew sonarqube"
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
                                            pmdParser(pattern: 'build/reports/pmd/*.xml'),
                                            spotBugs(pattern: 'build/reports/spotbugs/*.xml', useRankAsPriority: true)
                                    ]
                            )
                        }
                    }
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                //sh './gradlew assemble'
                //****SE PODRIA GENERAR UN CONTENEDOR****
                sh 'docker-compose build'
            }
        }
        stage('Security') {
            steps {
                echo 'Se realiza el analisis de seguridad en contenedor ..'
                sh 'trivy image --format=json --output=trivy-image.json hello-spring-test:latest'
            }
            post {
                always {
                    recordIssues(
                            enabledForFailure: true,
                            aggregatingResults: true,
                            tool: trivy(pattern: 'trivy-*.json')
                    )
                }
            }
        }
        //stage('Archive'){
        //    steps{
        //        echo 'Archivando..'
        //        archiveArtifacts artifacts: 'build/libs/*.jar'
        //    }
        //}
        stage('Deploying') {
            steps {
                echo 'Se ha archivado el artefacto, desplegando ..'
                //        sh 'docker-compose up -d'
            }
        }
    }
}
