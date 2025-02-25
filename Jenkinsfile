pipeline {
    agent any 
  
    environment {        
        GIT_URL = 'https://gitlab.com/hamrashilar/spring.git' 
        GIT_BRANCH = 'Jenkins_integration'    
        DOCKER_TLS_CERTDIR = ''  
        KUBE_VERSION = sh(script: 'curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt', returnStdout: true).trim()
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION    = 'ap-south-1'

   }

    
        
 
    stages {
        stage('Activate dockersock') {
            steps {
            script {
                sh ' sudo chmod 777 /var/run/docker.sock'
                sh ' sudo ls -l /var/run/docker.sock'
            }

        }
        }

        stage('Update ips ') {
            agent {
        docker { 
            image 'alpine:latest'
            args '--user root' 
        }
        }
        steps {
            script {
                sh 'apk add aws-cli'
                sh 'aws s3 ls'
                sh 'aws s3 ls s3://testing-s3-bucket-007/'
                sh 'pwd'
                sh 'aws s3 cp s3://testing-s3-bucket-007/control_plane_ip .'
                sh 'aws s3 cp s3://testing-s3-bucket-007/worker_node_ip .'
                sh 'aws s3 cp s3://testing-s3-bucket-007/admin.conf .'
                sh 'ls'
                sh 'cat $(worker_node_ip)'
                sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" frontend/index.html'
                sh 'cat frontend/index.html'
                sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" product-service/src/main/java/com.example.product/CorsConfig.java'
                sh 'cat product-service/src/main/java/com.example.product/CorsConfig.java'
                sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" user-service/src/main/java/com.example.user/CorsConfig.java'
                sh 'cat user-service/src/main/java/com.example.user/CorsConfig.java'

                
                


            }
        }

        }
        stage('Build User App') {
            agent {
              docker { 
               image 'docker:20.10-dind'
               args '--privileged -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=""'
        }  
    }

            steps {
                script {
                        sh 'cat $(worker_node_ip)'
                        sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" frontend/index.html'
                        sh 'cat frontend/index.html'
                        sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" product-service/src/main/java/com.example.product/CorsConfig.java'
                        sh 'cat product-service/src/main/java/com.example.product/CorsConfig.java'
                        sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" user-service/src/main/java/com.example.user/CorsConfig.java'
                        sh 'cat user-service/src/main/java/com.example.user/CorsConfig.java'

                        sh 'docker build -t user_app:latest -f Dockerfile.user .'
                    withDockerRegistry([credentialsId: 'Gitlab_Reg_Access', url: 'https://registry.gitlab.com']) {
                        sh 'docker tag user_app:latest registry.gitlab.com/hamrashilar/spring/user_app:latest'
                        sh 'docker push registry.gitlab.com/hamrashilar/spring/user_app:latest'
                    }
                }
            }
        }

        stage('Build Product App') {
            agent {
        docker { 
            image 'docker:20.10-dind'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=""'
        }  
    }

            steps {
                script {
                    sh 'cat $(worker_node_ip)'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" frontend/index.html'
                    sh 'cat frontend/index.html'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" product-service/src/main/java/com.example.product/CorsConfig.java'
                    sh 'cat product-service/src/main/java/com.example.product/CorsConfig.java'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" user-service/src/main/java/com.example.user/CorsConfig.java'
                    sh 'cat user-service/src/main/java/com.example.user/CorsConfig.java'

                    sh 'docker build -t product_app:latest -f Dockerfile.product .'
                    withDockerRegistry([credentialsId: 'Gitlab_Reg_Access', url: 'https://registry.gitlab.com']) {
                        sh 'docker tag product_app:latest registry.gitlab.com/hamrashilar/spring/product_app:latest'
                        sh 'docker push registry.gitlab.com/hamrashilar/spring/product_app:latest'
                    }
                }
            }
        }

        stage('Build Front End') {
            agent {
        docker { 
            image 'docker:20.10-dind'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=""'
        }  
    }

            steps {
                script {
                    sh 'cat $(worker_node_ip)'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" frontend/index.html'
                    sh 'cat frontend/index.html'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" product-service/src/main/java/com.example.product/CorsConfig.java'
                    sh 'cat product-service/src/main/java/com.example.product/CorsConfig.java'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" user-service/src/main/java/com.example.user/CorsConfig.java'
                    sh 'cat user-service/src/main/java/com.example.user/CorsConfig.java'

                    sh 'docker build -t front_end:latest -f Dockerfile.frontend .'
                    withDockerRegistry([credentialsId: 'Gitlab_Reg_Access', url: 'https://registry.gitlab.com']) {
                        sh 'docker tag front_end:latest registry.gitlab.com/hamrashilar/spring/front_end:latest'
                        sh 'docker push registry.gitlab.com/hamrashilar/spring/front_end:latest'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            agent {
        docker { 
            image 'alpine:latest'
            args '--user root -e KUBE_CONFIG'
        }  
    }
        steps {
           
              script {
                    sh 'cat $(worker_node_ip)'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" frontend/index.html'
                    sh 'cat frontend/index.html'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" product-service/src/main/java/com.example.product/CorsConfig.java'
                    sh 'cat product-service/src/main/java/com.example.product/CorsConfig.java'
                    sh 'sed -i "s|\\(http://\\)[^:]*\\(:3000\\)|\\1$(cat worker_node_ip)\\2|" user-service/src/main/java/com.example.user/CorsConfig.java'
                    sh 'cat user-service/src/main/java/com.example.user/CorsConfig.java'

                    sh 'apk add curl'
                    sh 'curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl'
                    sh 'chmod a+x /usr/local/bin/kubectl'
                    sh 'mkdir -p ~/.kube'
                    sh 'cp admin.conf ~/.kube/config'
                    sh 'cat ~/.kube/config'
                    // Validate the Kubernetes setup
                    sh 'kubectl get nodes'

                    // Apply Kubernetes manifests
                    sh 'kubectl apply -f k8s/product_app_deployment.yaml'
                    sh 'kubectl apply -f k8s/user_app_deployment.yaml'
                    sh 'kubectl apply -f k8s/front_end_deployment.yaml'
                    sh 'kubectl apply -f k8s/product_service.yaml'
                    sh 'kubectl apply -f k8s/user_service.yaml'
                    sh 'kubectl apply -f k8s/front_end_service.yaml'
                }
                
            }
        }
    }
}

