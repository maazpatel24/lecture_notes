pipeline {
    agent any
    environment {
        imageName = 'maazpatel24/day14-javaapp'
        tag = 'v1.0'
        dockerImage = ''
        containerName = 'my-day14-javaApp'
        dockerHubCredentials = 'maazpatel24-docker'
    }

    stages {
        stage ('Checkout') {
            steps {
                git url: 'https://github.com/maazpatel24/Day14-Docker-with-Jenkins.git', branch: 'master'
            }
        }
        stage ('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build"${imageName}:${tag}"
                }
            }
        }
        stage ('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', dockerHubCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage ('Deploy Container') {
            steps {
                script {
                    sh "docker run -d -p 5051:80 --name ${containerName} ${imageName}:${tag}"
                }
            }
        }

    }
    post {
        success {
            echo 'Build and test succeeded!'
        }
        failure {
            echo 'Build or test failed!'
        }
    }
}