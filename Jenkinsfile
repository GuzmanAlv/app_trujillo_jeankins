pipeline {
    agent any

    environment {
        FLUTTER_HOME = 'C:\\Users\\PC\\Documents\\ciclo7\\flutter'
        PATH = "${env.FLUTTER_HOME}\\bin;${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verificar herramientas') {
            steps {
                bat 'flutter --version'
                bat 'dart --version'
            }
        }

      

        stage('Instalar dependencias') {
            steps {
                bat 'flutter clean'
                bat 'flutter pub get'
            }
        }

        stage('Analizar código') {
            steps {
                bat 'flutter analyze'
            }
        }

        stage('Compilar Flutter Web') {
            steps {
                bat 'flutter build web --release'
            }
        }

        stage('Publicar artefacto') {
            steps {
                archiveArtifacts artifacts: 'build/web/**', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Pipeline completado: JSON validado, frontend compilado y artefacto publicado.'
        }
        failure {
            echo 'Pipeline falló. Revisa si el JSON, dependencias o build tienen errores.'
        }
    }
}
