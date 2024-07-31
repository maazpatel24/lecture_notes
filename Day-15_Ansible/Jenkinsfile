pipeline {
    agent any
    environment {
        imageName = 'maazpatel24/day15-webapp'
        dockerImage = ''
        containerName = 'my-day15-webApp'
        dockerHubCredentials = 'maazpatel24-docker'
    }

    stages {
        stage ('Checkout') {
            steps {
                git url: 'https://github.com/maazpatel24/Day14-Docker-with-Jenkins.git', branch: 'develop'
            }
        }
        stage ('Building Image') {
            steps {
                script {
                    dockerImage = docker.build"${imageName}:v2.0"
                }
            }
        }
        stage ('Docker Push') {
            steps {
                script {
                    docker.withRegistry('', dockerHubCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage ('Running image') {
            steps {
                script {
                    sh "docker run -d -p 5051:80 --name ${containerName} ${imageName}:v2.0"
                }
            }
        }
        
    }
}