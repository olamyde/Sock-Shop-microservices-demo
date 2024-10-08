pipeline {
    agent any

    environment {
        MYSQL_ROOT_PASSWORD = 'my-secret-pw'
        DOCKER_COMPOSE_FILE = "deploy/docker-compose/docker-compose.yml"
        DOCKERHUB_CREDENTIALS = credentials('s7deji-dockerhub')
        DOCKERHUB_REPO = 'olamyde/sock-shop-microservices-app'
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
                    sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d'
                    sh 'docker images'
                    sh 'docker tag weaveworksdemos/front-end:0.3.12 olamyde/sock-shop-microservices-app:front-end'
                    sh 'docker tag weaveworksdemos/edge-router:0.1.1 ${DOCKERHUB_REPO}:edge-router'
                    sh 'docker tag weaveworksdemos/catalogue:0.3.5 ${DOCKERHUB_REPO}:catalogue'
                    sh 'docker tag weaveworksdemos/catalogue-db:0.3.0 ${DOCKERHUB_REPO}:catalogue-db'
                    sh 'docker tag weaveworksdemos/carts:0.4.8 ${DOCKERHUB_REPO}:carts'
                    sh 'docker tag weaveworksdemos/orders:0.4.7 ${DOCKERHUB_REPO}:orders'
                    sh 'docker tag weaveworksdemos/shipping:0.4.8 ${DOCKERHUB_REPO}:shipping'
                    sh 'docker tag weaveworksdemos/queue-master:0.3.1 ${DOCKERHUB_REPO}:queue-master'
                    sh 'docker tag weaveworksdemos/payment:0.4.3 ${DOCKERHUB_REPO}:payment'
                    sh 'docker tag weaveworksdemos/user:0.4.4 ${DOCKERHUB_REPO}:user'
                    sh 'docker tag weaveworksdemos/user-db:0.4.0 ${DOCKERHUB_REPO}:user-db'
                    sh 'docker tag weaveworksdemos/load-test:0.1.1 ${DOCKERHUB_REPO}:load-test'
                    // Add tagging for other images as needed
                }
            }
        }

        stage('Push Docker Images to DockerHub') {
            steps {
                script {
                    // Push images to DockerHub
                    sh 'docker push olamyde/sock-shop-microservices-app:front-end'
                    sh 'docker push ${DOCKERHUB_REPO}:edge-router'
                    sh 'docker push ${DOCKERHUB_REPO}:catalogue'
                    sh 'docker push ${DOCKERHUB_REPO}:catalogue-db'
                    sh 'docker push ${DOCKERHUB_REPO}:carts'
                    sh 'docker push ${DOCKERHUB_REPO}:orders'
                    sh 'docker push ${DOCKERHUB_REPO}:shipping'
                    sh 'docker push ${DOCKERHUB_REPO}:queue-master'
                    sh 'docker push ${DOCKERHUB_REPO}:payment'
                    sh 'docker push ${DOCKERHUB_REPO}:user'
                    sh 'docker push ${DOCKERHUB_REPO}:load-test'
                    // Add push commands for other images as needed
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
