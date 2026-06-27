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

        

        stage('Compilar Flutter Web') {
            steps {
                bat 'flutter build web --release'
            }
        }
        stage('Publicar en GitHub Pages') {
    steps {
        bat '''
        cd build\\web
        git init
        git config user.name "Jenkins"
        git config user.email "jenkins@local.com"
        git add .
        git commit -m "Deploy automático desde Jenkins"
        git branch -M gh-pages
        git remote add origin https://github.com/GuzmanAlv/app_trujillo_jeankins.git
        git push -f origin gh-pages
        '''
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
