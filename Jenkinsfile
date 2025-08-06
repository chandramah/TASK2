pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/chandramah/TASK2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("jenkins-node-app")
                }
            }
        }

        stage('Test') {
            steps {
                echo 'No tests to run yet.'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Simulating deploy step.'
            }
        }
    }
}
