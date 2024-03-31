Created a vpc called alamyvpc, assuming with one public and private subnet
Created public and Private Subnets
Internet gateway is necessary to have Internet connection to Public Subnet. So created an IGW.
Route table is used to provide the routes to where the request should go. Created RT and attached it IGW.
Also associated RT with Subnets.

Created VPC using terraform module, enabled NAT gateway and RT and IGW will automatically created by subnetes.
Created configuration for creating IAM users and service users (IAM roles). IAM Role with policies to access resources
Created EC2 instance with a security group


Here's an example Kubernetes manifest to deploy a lightweight application, deplyoing a simple NGINX web server


Deployment.yml: Defines the deployment configuration for NGINX with 3 replicas.
    HorizontalPodAutoscaler: Configures auto-scaling based on CPU utilization targeting an average CPU utilization of 50% and scales between 3 and 10 replicas.

RBAC (Role and RoleBinding): Defines RBAC rules for accessing pods and logs within the Kubernetes cluster. It grants permissions to the default ServiceAccount in the default namespace.

deployed using minikube cluster in my local below are the results.

nagaraju@DESKTOP-EARJOBE:~$ kubectl apply -f ngnix.yml
deployment.apps/nginx-deployment created
service/nginx-service created
role.rbac.authorization.k8s.io/nginx-role created
rolebinding.rbac.authorization.k8s.io/nginx-role-binding created
error: resource mapping not found for name: "nginx-autoscaler" namespace: "" from "ngnix.yml": no matches for kind "HorizontalPodAutoscaler" in version "autoscaling/v2beta2"
ensure CRDs are installed first

nagaraju@DESKTOP-EARJOBE:~$ kubectl apply -f ngnix.yml
deployment.apps/nginx-deployment created
service/nginx-service created
role.rbac.authorization.k8s.io/nginx-role created
rolebinding.rbac.authorization.k8s.io/nginx-role-binding created
error: resource mapping not found for name: "nginx-autoscaler" namespace: "" from "ngnix.yml": no matches for kind "HorizontalPodAutoscaler" in version "autoscaling/v2beta2"
ensure CRDs are installed first

Terraform pipeline script:

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                script {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Format') {
            steps {
                script {
                    sh 'terraform fmt -check'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Manual Approval') {
            steps {
                input "Do you approve the Terraform plan? Click 'Proceed' to apply changes."
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

K8's pipeline script:

pipeline {
    agent any

    environment {
        KUBECONFIG = "${WORKSPACE}/path/to/your/kubeconfig"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Kubectl Apply') {
            steps {
                script {
                    sh 'kubectl apply -f /path/to/your/kubernetes/manifests'
                }
            }
        }

        stage('Verify') {
            steps {
                script {
                    sh 'kubectl get pods'
                    // You can add more verification steps here
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
