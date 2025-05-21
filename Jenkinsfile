
pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/yourusername/tiktok-java.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t tiktokapp ./docker'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker run -d -p 8080:8080 tiktokapp'
            }
        }
    }
}
