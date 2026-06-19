# ☁️ CloudShield-DR

## Enterprise Disaster Recovery Platform using Terraform & AWS

<p align="center">

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge\&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge\&logo=amazonaws)
![Python](https://img.shields.io/badge/Python-Lambda-blue?style=for-the-badge\&logo=python)
![EC2](https://img.shields.io/badge/EC2-Compute-orange?style=for-the-badge)
![RDS](https://img.shields.io/badge/RDS-MySQL-blue?style=for-the-badge)
![S3](https://img.shields.io/badge/S3-Backup-green?style=for-the-badge)
![CloudWatch](https://img.shields.io/badge/CloudWatch-Monitoring-red?style=for-the-badge)
![SNS](https://img.shields.io/badge/SNS-Notifications-yellow?style=for-the-badge)
![Lambda](https://img.shields.io/badge/Lambda-Automation-orange?style=for-the-badge)

</p>

---

# 📌 Project Overview

CloudShield-DR is an enterprise-inspired **Disaster Recovery Platform** built on **Amazon Web Services (AWS)** using **Terraform** as Infrastructure as Code (IaC).

The project provisions cloud infrastructure across **two AWS Regions**, monitors infrastructure health using **Amazon CloudWatch**, sends notifications through **Amazon SNS**, executes recovery workflows using **AWS Lambda**, automates **EBS & RDS snapshots**, and replicates backup data to a secondary AWS Region using **Amazon S3 Cross-Region Replication**.

The project follows a modular Terraform architecture with separate deployments for the Primary Region, Disaster Recovery Region, and Global Resources.

---

# 🚀 Key Features

* Infrastructure as Code (Terraform)
* Modular Terraform Architecture
* Multi-Region AWS Deployment
* Amazon EC2 Web Server
* Amazon RDS MySQL Database
* Application Load Balancer
* Amazon S3 Backup Storage
* S3 Versioning
* Cross-Region S3 Replication
* Amazon CloudWatch Monitoring
* Amazon SNS Email Notifications
* AWS Lambda Recovery Workflow
* Automated EBS Snapshots
* Automated RDS Snapshots
* IAM Least Privilege Policies
* Secure VPC Networking
* AWS Systems Manager Session Manager

---

# 🏗 Solution Architecture

```text
                         Users
                           │
                           ▼
               Application Load Balancer
                           │
                           ▼
                    Amazon EC2 Instance
                           │
        ┌──────────────────┴─────────────────┐
        │                                    │
        ▼                                    ▼
 Amazon CloudWatch                     Amazon RDS
        │                              MySQL Database
        ▼                                    │
 Amazon SNS                           RDS Snapshots
        │
        ▼
 AWS Lambda
        │
        ▼
 Recovery Workflow
        │
        ▼
 Amazon S3 Backup
        │
 Cross-Region Replication
        │
        ▼
 Disaster Recovery Region
```

---

# 🌍 Disaster Recovery Architecture

```text
             PRIMARY REGION
         Mumbai (ap-south-1)

      ┌──────────────────────┐
      │ EC2                  │
      │ ALB                  │
      │ RDS                  │
      │ S3                   │
      │ CloudWatch           │
      │ SNS                  │
      │ Lambda               │
      └──────────┬───────────┘
                 │
     Cross-Region Replication
                 │
                 ▼
      ┌──────────────────────┐
      │ Hyderabad            │
      │ Disaster Recovery    │
      │ Replicated S3 Bucket │
      │ Standby Environment  │
      └──────────────────────┘
```

---

# ☁️ AWS Services Used

| Service                   | Purpose                |
| ------------------------- | ---------------------- |
| Amazon EC2                | Application Server     |
| Amazon VPC                | Network Isolation      |
| Amazon RDS MySQL          | Database               |
| Amazon S3                 | Backup Storage         |
| Application Load Balancer | Traffic Distribution   |
| Amazon CloudWatch         | Monitoring             |
| Amazon SNS                | Notifications          |
| AWS Lambda                | Recovery Automation    |
| Amazon EBS                | Persistent Storage     |
| IAM                       | Access Management      |
| AWS Systems Manager       | Secure EC2 Management  |
| Terraform                 | Infrastructure as Code |

---

# 📂 Project Structure

```text
CloudShield-DR
│
├── terraform/
├── terraform-dr/
├── terraform-global/
├── screenshots/
├── architecture/
├── documentation/
├── lambda/
├── scripts/
├── README.md
└── .gitignore
```

---

# 🏗 Terraform Architecture

The project is divided into **three independent Terraform deployments**.

| Folder                | Purpose                                                                |
| --------------------- | ---------------------------------------------------------------------- |
| **terraform/**        | Deploys the Primary Infrastructure in Mumbai (ap-south-1)              |
| **terraform-dr/**     | Deploys the Disaster Recovery Infrastructure in Hyderabad (ap-south-2) |
| **terraform-global/** | Configures Global Resources including S3 Cross-Region Replication      |

---

# 📦 Terraform Modules

| Module       | Purpose                                                    |
| ------------ | ---------------------------------------------------------- |
| Network      | Creates VPC, Subnets, Internet Gateway & Route Tables      |
| Security     | Creates Security Groups for EC2, ALB & RDS                 |
| Compute      | Deploys EC2, IAM Role & User Data                          |
| ALB          | Creates Application Load Balancer, Listener & Target Group |
| RDS          | Deploys Amazon RDS MySQL                                   |
| S3           | Creates Versioned & Encrypted Backup Bucket                |
| CloudWatch   | Creates CPU & Status Check Alarms                          |
| SNS          | Creates Email Notification Topic                           |
| Lambda       | Executes Recovery Workflow                                 |
| EBS Snapshot | Automates Daily EBS Snapshots                              |
| RDS Snapshot | Automates Daily RDS Snapshots                              |

---

# 🔄 Infrastructure Workflow

```text id="lqce8d"
Terraform Code
      │
      ▼
terraform init
      │
      ▼
terraform validate
      │
      ▼
terraform plan
      │
      ▼
terraform apply
      │
      ▼
AWS Infrastructure Created
```

---

# 🔁 Monitoring & Recovery Workflow

```text
CloudWatch Alarm
        │
        ▼
Amazon SNS
        │
        ▼
Email Notification
        │
        ▼
AWS Lambda
        │
        ▼
Recovery Workflow Initiated
```

---

# 💾 Backup Workflow

```text
Amazon EBS
      │
      ▼
Daily Snapshot

Amazon RDS
      │
      ▼
Daily Snapshot

Amazon S3
      │
      ▼
Cross-Region Replication
      │
      ▼
Disaster Recovery Region
```

---

# 🚀 Deployment

## Deploy Primary Infrastructure

```bash
cd terraform

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## Deploy Disaster Recovery Infrastructure

```bash
cd terraform-dr

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## Deploy Global Resources

```bash
cd terraform-global

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

# ✅ Validation

| Component                        | Status |
| -------------------------------- | ------ |
| Terraform Validation             | ✅      |
| Primary Infrastructure           | ✅      |
| Disaster Recovery Infrastructure | ✅      |
| Application Load Balancer        | ✅      |
| Amazon EC2                       | ✅      |
| Amazon RDS                       | ✅      |
| Amazon S3                        | ✅      |
| Cross-Region Replication         | ✅      |
| CloudWatch Alarms                | ✅      |
| Amazon SNS                       | ✅      |
| AWS Lambda Deployment            | ✅      |
| EBS Snapshot Automation          | ✅      |
| RDS Snapshot Automation          | ✅      |
| Session Manager Access           | ✅      |

---

# 📸 Project Screenshots

Include screenshots of:

* Architecture Diagram
* Terraform Apply
* Primary & DR EC2 Instances
* Application Load Balancer
* Amazon RDS
* Amazon S3
* Cross-Region Replication
* CloudWatch Alarms
* Amazon SNS
* AWS Lambda
* AWS Systems Manager Session Manager
💻 Tech Stack
Cloud Platform
Amazon Web Services (AWS)
Infrastructure as Code
Terraform
Programming Language
Python
Compute
Amazon EC2
Database
Amazon RDS MySQL
Storage
Amazon S3
Networking
Amazon VPC
Application Load Balancer
Internet Gateway
Security Groups
Route Tables
Monitoring & Notifications
Amazon CloudWatch
Amazon SNS
Automation
AWS Lambda
Administration
AWS Systems Manager Session Manager
🎯 Skills Demonstrated
Infrastructure as Code (Terraform)
AWS Cloud Architecture
Disaster Recovery Planning
Multi-Region Infrastructure
Cloud Networking
Infrastructure Monitoring
Backup & Recovery
Cloud Automation
IAM Policy Management
Amazon S3 Cross-Region Replication
Infrastructure Security
Cloud Cost Optimization
DevOps Best Practices
🔒 Security Features
Infrastructure provisioned using Terraform
IAM Least Privilege Policies
Private Database Deployment
Encrypted Amazon S3 Storage
Versioned Backup Storage
Public Access Block Enabled
Security Group Isolation
CloudWatch Monitoring
Email Alerting using Amazon SNS
🚧 Future Enhancements
Route 53 DNS Failover
Auto Scaling Groups
Amazon ECS / Fargate
Amazon EKS
AWS Backup
CloudTrail
AWS Config
GuardDuty
GitHub Actions CI/CD
Terraform Remote Backend
DynamoDB State Locking


👨‍💻 Author
Nikhil Chamyal

Cloud Engineer | DevOps Engineer



