pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = "deploy/docker-compose/docker-compose.yml"
        DOCKERHUB_CREDENTIALS = credentials('s7deji-dockerhub')
        DOCKERHUB_REPO = 'olamyde/sock-shop-microservices-app/'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/olamyde/Sock-Shop-microservices-demo.git'
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    // Login to DockerHub using Jenkins credentials
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                }
            }
        }

        stage('Build and Tag Docker Images') {
            steps {
                script {
                    // Build and tag each image
                    sh 'docker-compose -f $DOCKER_COMPOSE_FILE build'
                    sh 'docker images'
                    
                    // Add tagging for other images as needed
                }
            }
        }

      
        stage('Clean up') {
            steps {
                script {
                    // Clean up stopped containers and volumes
                    sh 'docker-compose -f $DOCKER_COMPOSE_FILE down'
                }
            }
        }
    }

    post {
        always {
            // Cleanup any leftover Docker resources
            sh 'docker-compose -f $DOCKER_COMPOSE_FILE down --volumes'
        }
    }
}
