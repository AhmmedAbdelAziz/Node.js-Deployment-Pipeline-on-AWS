pipeline {
    agent any
      environment {
          AWS_ACCESS_KEY_ID=credentials('aws_access')
          AWS_SECRET_ACCESS_KEY=credentials('aws_secret')
      }
      stages {
          stage('git') {
              steps {
                  echo 'get the code'
                  git branch: 'main', url: 'http://192.168.127.146/root/nodejs-app.git'
              }
          }
          stage('build') {
              steps {
                  echo 'building the software'
                  sh 'npm install'
              }
          }
          stage('test') {
              steps {
                  echo 'testing the software'
                  sh 'npm test'
              }
          }
          stage('deploy') {
              steps {
                  echo 'deploy the software'
                  sh 'node index.js &'
              }
          }
          stage('Deploy on AWS') {
            steps {
                script {
                    dir('terraform') {
                        sh 'cat <EOF > backend.tf 
                            terraform {
                                        backend "s3" {
                                        bucket = "mybucket"
                                        key    = "terraform.tfstate"
                                        region = "eu-west-3"
                                        dynamodb_table = "mytable"
                                        encrypt = true
                                    }
                                    }
                                    EOF'
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                        sh '''
                              IP1=$(terraform output -raw public_ip_1)
                              IP2=$(terraform output -raw public_ip_2)
                              echo "[apps]\n$IP1\n$IP2" > /opt/inventory
                            '''
                        sh 'rm -rf /opt/pure/{,.[!.],..?}*'
                        sh 'git clone http://192.168.127.146/root/nodejs-app.git /opt/pure'
                    }
                }
                
                
            }
        }
        
        stage('Ansible playbook to run app') {
            steps {
                ansiblePlaybook(
                    playbook: '/opt/playbook.yml',
                    inventory: '/opt/inventory'
                )
            }
        }
        
        
        
      
        
        
    }
}
