pipeline {
    agent any
   parameters {
        string(name: 'REGION', defaultValue: 'ap-south-1', description: 'Select the region')
    }
    environment {
        AWS_DEFAULT_REGION = "${params.REGION}" // Set your desired AWS region
        AWS_CONFIGURE = credentials('aws_credentials')
        //  withCredentials([aws(credentialsId: 'aws_credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')])
    }

    stages {
        stage('Checkout') {
            steps {
               git branch: 'main', changelog: false, credentialsId: 'Git_credentials', poll: false, url: 'https://github.com/srinivasarao-ceq/jenkins_final-assignment.git'
            }
        }
         stage('aws') {
            steps {
                sh 'aws s3 ls'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -reconfigure'
            }
        }

        stage('Terraform Plan') {

             when{
                 expression {
                           return env.CHANGE_ID != null
                   }
             //  changeset "[https://github.com/srinivasarao-ceq/jenkins_final-assignment.git]"
             }
            steps {
                 sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
               when{
                 expression {
                           changeset "main/**"
                }         
         }
            steps {
                sh 'terraform apply -auto-approve'
            }
        }   

        // stage('Terraform destroy') {
        //     steps {
        //         sh 'terraform destroy -auto-approve'
        //     }
        // }  

    }
}
