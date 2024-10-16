pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select the action to create or destory aws infra.')
    }
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout Source Code') {
            steps {
                script {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/srdangat/tf-jen.git']])
                }
            }
        }
        stage('Initialize Terraform') {
            steps {
                script {
                    dir('vpc_sg_alb_asg') {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Format Terraform Configuration') {
            steps {
                script {
                    dir('vpc_sg_alb_asg') {
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validate Terraform Configuration') {
            steps {
                script {
                    dir('vpc_sg_alb_asg') {
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Terraform Plan Preview') {
            steps {
                script {
                    dir('vpc_sg_alb_asg') {
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage('Create/Destroy Aws Infra') {
            steps {
                script {
                    dir('vpc_sg_alb_asg') {
                        sh 'terraform $ACTION --auto-approve'
                    }
                }
            }
        }
    }
}