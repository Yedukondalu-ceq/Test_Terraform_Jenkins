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
               git branch: 'main', changelog: false, poll: false, url: 'https://github.com/Yedukondalu-ceq/Test_Terraform_Jenkins.git'
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
             //  changeset "[https://github.com/Yedukondalu-ceq/Test_Terraform_Jenkins.git]"
             }
            steps {
                 sh 'terraform plan'
            }
        }

        //stage('Terraform Apply') {
             //  when{
            //     expression {
           //                changeset "main/**"
         //       }         
        // }
       //     steps {
      //          sh 'terraform apply -auto-approve'
     //       }
    //    }   

         stage('Terraform destroy') {
           when{
                 expression {
                           changeset "main/**"
                }         
           }
           steps {
             sh 'terraform destroy -auto-approve'
           }
        } 
    }
}
