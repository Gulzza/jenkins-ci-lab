pipeline {
  agent none

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {

    stage('Checkout') {
      agent { label 'mac' }
      steps {
        checkout scm
        sh 'chmod +x app/app.sh tests/test.sh || true'
        stash name: 'src', includes: '**/*'
      }
    }

    stage('Build on mac-agent') {
      agent { label 'mac' }
      steps {
        unstash 'src'
        sh '''
          echo "=============================="
          echo "BUILD STAGE"
          echo "Running on host: $(hostname)"
          echo "Workspace: $(pwd)"
          echo "=============================="
          ./app/app.sh
        '''
      }
    }

    stage('Test on agent2') {
      agent { label 'mac' }
      steps {
        unstash 'src'
        sh '''
          echo "=============================="
          echo "TEST STAGE"
          echo "Running on host: $(hostname)"
          echo "Workspace: $(pwd)"
          echo "=============================="
          ./tests/test.sh
        '''
      }
    }
  }

  post {
    success { echo "✅ PIPELINE SUCCESS" }
    failure { echo "❌ PIPELINE FAILED" }
    always {
      node('mac') { cleanWs() }
    }
  }
}
