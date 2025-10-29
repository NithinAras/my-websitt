pipeline {
    agent any
    
    environment {
        IMAGE_NAME = "my-website"
        CONTAINER_NAME = "my-website-container"
        PORT = "8081"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code from repository...'
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                script {
                    sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
                    sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
                }
            }
        }
        
        stage('Stop Old Container') {
            steps {
                echo '🛑 Stopping old container...'
                script {
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo '🚀 Deploying new container...'
                script {
                    sh """
                        docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p ${PORT}:80 \
                        ${IMAGE_NAME}:latest
                    """
                }
                echo "🌐 Website deployed at: http://localhost:${PORT}"
            }
        }
    }
    
    post {
        success {
            echo '✅ Pipeline completed successfully!'
            echo "🌐 Visit your website at: http://localhost:${PORT}"
        }
        failure {
            echo '❌ Pipeline failed!'
        }
        always {
            echo '🧹 Cleaning up old images...'
            sh 'docker image prune -f'
        }
    }
}
