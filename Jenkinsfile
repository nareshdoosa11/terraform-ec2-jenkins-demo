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
        powershell '''
        terraform plan -out=tfplan `
            -var "region=us-east-1" `
            -var "access_key=${env.AWS_ACCESS_KEY_ID}" `
            -var "secret_key=${env.AWS_SECRET_ACCESS_KEY}" `
            -var "ami_id=ami-0360c520857e3138f" `
            -var "instance_type=t2.micro"
        '''
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
