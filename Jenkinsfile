pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nareshdoosa11/terraform-ec2-jenkins-demo.git'
            }
        }

        stage('Init Terraform') {
            steps {
                powershell 'terraform init'
            }
        }

        stage('Validate Terraform') {
            steps {
                powershell 'terraform validate'
            }
        }

        stage('Plan Terraform') {
            steps {
                powershell 'terraform plan -out=tfplan'
            }
        }

        stage('Apply Terraform') {
            steps {
                powershell 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete!'
        }
    }
}
