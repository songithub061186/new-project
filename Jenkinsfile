pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Choose to destroy the infrastructure?') // New destroy parameter
    }

    environment {
        AWS_CREDENTIALS = credentials('aws-crendentails-JERSON POGI') // Fetch the secret
    }

    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    dir("terraform") {
                        git branch: 'main', url: 'https://github.com/songithub061186/new-project.git'
                    }
                }
            }
        }

        stage('Plan') {
            steps {
                sh 'pwd;cd terraform/ ; terraform init'
                sh 'pwd;cd terraform/ ; terraform plan -out tfplan'
                sh 'pwd;cd terraform/ ; terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }

            steps {
                script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply or Destroy') {
            steps {
                script {
                    if (params.destroy) {
                        echo "Destroying infrastructure..."
                        sh 'pwd;cd terraform/ ; terraform destroy -auto-approve' // Destroy command
                    } else {
                        echo "Applying plan..."
                        sh 'pwd;cd terraform/ ; terraform apply -input=false tfplan' // Apply command
                    }
                }
            }
        }
    }
}
