# AWS API Gateway + ECS Fargate

This is a sample Terraform AWS project for spinning up an API Gateway + ECS Fargate cluster hosting a microservice. The microservice is versioned as a Docker image on ECR. Logging is provided by CloudWatch.

## Architecture, cost optimizations, security, scalability, observability, alternative setups

1. Architecture

The API Gateway is the entry-point in the cluster, forwarding all the requests to an internal NLB which forwards the requests to the internal ECS Fargate cluster hosting the microservice.

The connectivity between the API Gateway and the internal NLB is achieved through a VPC Link, while the connectivity between the microservice and different AWS services like ECR, S3, and CloudWatch is achieved through VPC Endpoints.

Inventory of AWS services:
- VPC + route table + private subnets
- VPC Endpoints (ECR, S3, CloudWatch)
- Security Group
- ECS Fargate cluster + service + task definition
- ECS IAM role + policy
- NLB + Target Group + Listener
- CloudWatch
- API Gateway 
- VPC Link

2. Cost optimizations

Rather than using a NAT Gateway for enabling traffic between the cluster and ECR/S3/CloudWatch, VPC Endpoints are a cheaper alternative (see https://www.vantage.sh/blog/nat-gateway-vpc-endpoint-savings).

3. Security

The only public-facing endpoint is the API Gateway, while the NLB and ECS Fargate cluster live inside the private subnets.

The API Gateway provides SSL termination and a default SSL certificate (see https://aws.amazon.com/api-gateway/faqs). The internal connectivity between the NLB and ECS Fargate cluster is not secure.

At the firewall level of the VPC, only the following ports are opened through Security Groups:
- microservice's port (inbound)
- HTTPS (inbound/outbound)
- IPv6 (outbound)

4. Scalability

see https://docs.aws.amazon.com/AmazonECS/latest/userguide/clusters.html

5. Observability

Only CloudWatch at this moment, more to come later.

6. Alternative setups

- Approximately same costs, Layer 7 routing (not suitable for high throughput and ultra-low latencies): API Gateway + ALB + ECS Fargate
- More expensive, for senarios where you cannot use VPC Endpoints (e.g. external systems): API Gateway + LB + ECS Fargate + NAT Gateway
- Cheaper, but less secure (not suitable for production setups): LB + ECS Fargate deployed in public subnets, w/o API Gateway

## Local Terraform setup

1. Create a new AWS profile

~/.aws/credentials, ~/.aws/config

2. Switch to the new profile

export AWS_DEFAULT_PROFILE=<profile>

3. Initialize Terraform

terraform init

4. Spin up the infrastructure

terraform apply --var-file="env1.tfvars"

4. Teardown the infrastructure

terraform destroy --var-file="env1.tfvars"

## Live deployment

After Terraform successfully finished provisioning the infrastructure, go to AWS Console -> API Gateway -> Stages and access the public DNS that was made available by API Gateway (e.g. https://<id>.execute-api.eu-west-1.amazonaws.com/dev)
