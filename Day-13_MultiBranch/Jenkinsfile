pipeline {
    agent any

     environment {
        MAVEN_HOME = tool 'Maven-3.9.0' // Ensure this matches your Maven tool name
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // echo "Building in branch: ${env.BRANCH_NAME}"
                    withEnv(["PATH+MAVEN=${MAVEN_HOME}/bin"]) {
                        // Clean and compile the Maven project
                        sh 'mvn clean package'
                    }
                }
            }
        }
        stage('Run') {
            steps {
                script {
                    // echo "Building in branch: ${env.BRANCH_NAME}"
                    withEnv(["PATH+MAVEN=${MAVEN_HOME}/bin"]) {
                        sh 'mvn exec:java -Dexec.mainClass="com.example.App"'
                    }
                }
            }
        }
        stage('Archive Artifacts') {
            steps {
                // Archive the built artifacts
                archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
            // Clean up workspace
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}