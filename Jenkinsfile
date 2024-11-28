pipeline {
    agent any
  
    environment { 
        GIT_URL = 'https://gitlab.com/hamrashilar/spring.git'
        GIT_BRANCH = 'Jenkins_integration'   
        DOCKER_TLS_CERTDIR = '' 
        KUBE_VERSION = sh(script: 'curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt', returnStdout: true).trim()
        KUBE_CONFIG = credentials('kube_config') // Replace 'kube_config' with your Jenkins credential ID
    }

    
        
 
    stages {
        
    
        stage('Build User App') {
            agent {
              docker { 
               image 'docker:20.10-dind'
               args '--privileged -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=""'
        }  
    }

            steps {
                script {
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
        }  
    }
            steps {
                script {
                    sh 'curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl'
                    sh 'chmod a+x /usr/local/bin/kubectl'
                    sh 'mkdir -p ~/.kube'
                    sh 'echo "${KUBE_CONFIG}" > ~/.kube/config'

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
