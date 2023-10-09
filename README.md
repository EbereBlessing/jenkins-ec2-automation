# AUTOMATING JENKINS SET ON AWS EC2 WITH TERRAFORM
Terraform is an IaC tool that defines and provides infrastructure using a declarative configuration language. It provides a means to automate the creation and management of cloud resources, resulting in infrastructure deployments that are efficient, repeatable, and versioned.

Jenkins is an open source automation server that provides hundreds of plugins to support the creation, deployment, and automation of any project. You can automate the Jenkins installation process using Terraform,  to deploy Jenkins on Amazon Web Services (AWS) Elastic Compute Cloud (EC2) instances.

Below is a step-by-step guide to automating the provisioning of EC2 instances and installing Jenkins on the  EC2 instance using Terraform.
## Environment
- Terraform 
- AWS Account  free tier
- AWS CLI 
- Key Pair 
## How will we accomplish this task with Terraform?
1. Deploying an EC2 Instance on a Default VPC
2. Creating and assigning a Security Group to the instances that allows traffic on port 22 from the ip and allows traffic from port 8080
3. Bootstrap the EC2 instance with a script that will install and start Jenkins.
4. Create a S3 bucket for the Jenkins Artifacts that is not open to the public

- main.tf: contains the terraform configuration script that provisions the ec2 instance and it's dependencies
- Install_jenkins.sh : contains the defined bash script that installs and start up jenkins

## Run the terraform command to create the instance;
- terraform init 
- terraform plan 
- terraform validate
- terraform apply --auto-approve


Once the installation is complete the jenkins url can be obtained from the terraform outputs in the terminal console.
Connect to the instance using EC2 Instance Connect to obtain jenkins intial password by running the command below: to unlock Jenkins:

- sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Success!!



