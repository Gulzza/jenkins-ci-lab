pipeline {
    agent none   // IMPORTANT: controller does NOT run jobs

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            agent any
            steps {
                git branch: 'main',
                    url: 'https://github.com/YOUR_ORG/jenkins-ci-lab.git'
            }
        }

        stage('Build on mac-agent') {
            agent { label 'mac-agent' }
            steps {
                sh '''
                  echo "Build stage"
                  ./app/app.sh
                '''
            }
        }

        stage('Test on node-mac1') {
            agent { label 'node-mac1' }
            steps {
                sh '''
                  echo "Test stage"
                  ./tests/test.sh
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline SUCCESS"
        }
        failure {
            echo "Pipeline FAILED"
        }
        always {
            cleanWs()
        }
    }
}
