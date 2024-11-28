pipeline {
    agent any

    environment {
        GIT_URL = 'https://gitlab.com/hamrashilar/spring.git'
        GIT_BRANCH = 'Jenkins_integration'   
         
        KUBE_VERSION = sh(script: 'curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt', returnStdout: true).trim()
        KUBE_CONFIG = credentials('kube_config') // Replace 'kube_config' with your Jenkins credential ID
    }

    
        
 
    stages {
        stage('Clone GitLab Repo') {
            steps {
                git url: "$GIT_URL", branch: "$GIT_BRANCH"
            }
        }
    
        stage('Build User App') {
            
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
            steps {
                script {
                    sh 'echo "123" | sudo -S curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl'
                    sh 'echo "123" | sudo -S chmod a+x /usr/local/bin/kubectl'
                    sh 'echo "123" | sudo -S mkdir -p ~/.kube'
                    sh 'echo "123" | sudo -S echo "${KUBE_CONFIG}" > ~/.kube/config'

                    // Validate the Kubernetes setup
                    sh 'echo "123" | sudo -S kubectl get nodes'

                    // Apply Kubernetes manifests
                    sh 'echo "123" | sudo -S kubectl apply -f k8s/product_app_deployment.yaml'
                    sh 'echo "123" | sudo -S kubectl apply -f k8s/user_app_deployment.yaml'
                    sh 'echo "123" | sudo -S kubectl apply -f k8s/front_end_deployment.yaml'
                    sh 'echo "123" | sudo -S kubectl apply -f k8s/product_service.yaml'
                    sh 'echo "123" | sudo -S kubectl apply -f k8s/user_service.yaml'
                    sh 'echo "123" | sudo -S kubectl apply -f k8s/front_end_service.yaml'
                }
            }
        }
    }
}

