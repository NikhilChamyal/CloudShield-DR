# ☁️ CloudShield-DR

### Enterprise Disaster Recovery Platform using Terraform & AWS

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

CloudShield-DR is an enterprise-grade Disaster Recovery (DR) platform built completely using Infrastructure as Code (IaC) with Terraform on Amazon Web Services (AWS).

The project automatically provisions cloud infrastructure, continuously monitors workloads, creates automated backups, replicates critical storage to a secondary AWS region, and performs automated recovery actions whenever failures occur.

The primary objective of CloudShield-DR is to reduce downtime, improve business continuity, and demonstrate real-world cloud disaster recovery architecture similar to what is implemented in enterprise production environments.

---

# 🎯 Objectives

The project was developed with the following objectives:

* Automate AWS infrastructure provisioning using Terraform.
* Eliminate manual disaster recovery procedures.
* Monitor infrastructure health continuously.
* Generate automatic EBS and RDS backups.
* Replicate critical data to another AWS Region.
* Reduce Recovery Time Objective (RTO).
* Improve Recovery Point Objective (RPO).
* Demonstrate enterprise DevOps and Cloud Engineering practices.

---

# 🚀 Key Features

✅ Infrastructure as Code using Terraform

✅ Modular Terraform Architecture

✅ Multi-AZ Infrastructure

✅ Cross-Region Disaster Recovery

✅ Amazon EC2 Deployment

✅ Amazon RDS MySQL Database

✅ Amazon S3 Versioning

✅ Cross Region S3 Replication

✅ CloudWatch Monitoring

✅ SNS Email Notifications

✅ AWS Lambda Automation

✅ Automatic EC2 Recovery

✅ Automatic EBS Snapshots

✅ Automatic RDS Snapshots

✅ IAM Least Privilege Roles

✅ Application Load Balancer

✅ Security Groups

✅ Automated Monitoring & Alerting

---

# 🏗️ Solution Architecture

```
                           Users
                              │
                              │
                     Application Load Balancer
                              │
                    ┌─────────┴─────────┐
                    │                   │
              EC2 Web Server      CloudWatch
                    │                   │
                    │                   │
                    │              CPU / Status Alarm
                    │                   │
                    │                   ▼
               SNS Notifications ─────► Lambda
                    │                   │
                    │                   │
                    ▼                   ▼
            Email Notification     EC2 Auto Recovery
                    │
                    │
                    ▼
             Amazon RDS MySQL
                    │
         Automated RDS Snapshots
                    │
                    ▼
             Amazon S3 Backups
                    │
     Cross Region Replication
                    │
                    ▼
          Disaster Recovery Region
```

---

# 🌍 Disaster Recovery Architecture

```
                 PRIMARY REGION
                (Mumbai ap-south-1)

          ┌───────────────────────────┐
          │        EC2 Instance       │
          │                           │
          │        RDS Database       │
          │                           │
          │        S3 Bucket          │
          │                           │
          │   CloudWatch Monitoring   │
          │                           │
          │    SNS + Lambda           │
          └────────────┬──────────────┘
                       │
                       │
         Cross Region Replication
                       │
                       ▼

             SECONDARY REGION
             (Hyderabad ap-south-2)

          ┌───────────────────────────┐
          │      Replicated S3        │
          │                           │
          │    Standby Infrastructure │
          │                           │
          │  Disaster Recovery Ready  │
          └───────────────────────────┘
```

---

# ⚙️ Complete Project Workflow

```
Terraform Apply
        │
        ▼
AWS Infrastructure Provisioned
        │
        ▼
Deploy Application
        │
        ▼
CloudWatch Monitors Resources
        │
        ▼
CPU / Status Alarm Triggered
        │
        ▼
SNS Notification Sent
        │
        ▼
Lambda Triggered
        │
        ▼
EC2 Recovery Initiated
        │
        ▼
Service Restored
        │
        ▼
Automatic Daily Snapshots
        │
        ▼
S3 Cross Region Replication
        │
        ▼
Disaster Recovery Environment Ready
```

---

# 📊 AWS Services Used

| Service                   | Purpose                |
| ------------------------- | ---------------------- |
| Amazon EC2                | Web Server             |
| Amazon VPC                | Network Isolation      |
| Amazon RDS                | MySQL Database         |
| Amazon S3                 | Backup Storage         |
| Application Load Balancer | Traffic Distribution   |
| IAM                       | Secure Access Control  |
| CloudWatch                | Monitoring             |
| SNS                       | Notifications          |
| Lambda                    | Automated Recovery     |
| EventBridge               | Snapshot Scheduling    |
| EBS                       | Persistent Storage     |
| Terraform                 | Infrastructure as Code |

---

# 🧠 Skills Demonstrated

* AWS Cloud Architecture
* Disaster Recovery Planning
* Infrastructure as Code
* Terraform Modules
* Cloud Monitoring
* Cloud Automation
* High Availability
* Backup & Recovery
* Cloud Security
* IAM Policy Design
* AWS Networking
* Cloud Cost Optimization
* DevOps Best Practices
* Production Infrastructure Design
* Multi-Region Cloud Architecture

---

# 📁 Project Structure

```
CloudShield-DR
│
├── architecture/
│      Architecture Diagram
│
├── documentation/
│      Project Documentation
│
├── lambda/
│      Lambda Source Files
│
├── screenshots/
│      Project Screenshots
│
├── scripts/
│      Utility Scripts
│
├── terraform/
│      Primary Region Infrastructure (Mumbai)
│
├── terraform-dr/
│      Disaster Recovery Region Infrastructure (Hyderabad)
│
├── terraform-global/
│      Global Resources
│      ├── IAM
│      └── Cross Region S3 Replication
│
├── README.md
│
└── .gitignore
```

---

# 🏗 Terraform Architecture

The infrastructure is divided into three independent Terraform projects.

---

## 1️⃣ terraform/

Purpose:

Deploys the Primary Production Environment in the Mumbai Region (ap-south-1).

This folder provisions:

* Amazon VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* Route Tables
* Security Groups
* EC2 Web Server
* IAM Roles
* Application Load Balancer
* Amazon RDS MySQL
* Amazon S3 Backup Bucket
* CloudWatch Monitoring
* SNS Notifications
* Lambda Auto Recovery
* Automatic EBS Snapshots
* Automatic RDS Snapshots

---

## 2️⃣ terraform-dr/

Purpose:

Deploys the Disaster Recovery Infrastructure in the Hyderabad Region (ap-south-2).

Resources deployed:

* Separate VPC
* Public Subnets
* Private Subnets
* Security Groups
* EC2 Recovery Server
* Application Load Balancer
* Amazon RDS
* S3 Backup Bucket
* CloudWatch
* SNS
* Lambda Recovery
* Snapshot Automation

This environment remains available as the standby Disaster Recovery site.

---

## 3️⃣ terraform-global/

Purpose:

Deploys resources shared between both AWS Regions.

Resources:

* Cross Region S3 Replication
* IAM Replication Role
* Replication Policies

This configuration enables automatic backup replication from Mumbai to Hyderabad.

---

# 📦 Terraform Modules

The project follows a reusable modular Infrastructure as Code architecture.

---

## Network Module

Creates the networking layer.

Resources:

* VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* Route Tables
* NAT Gateway (Optional)

Outputs:

* VPC ID
* Subnet IDs
* Route Tables

---

## Security Module

Creates Security Groups for:

* EC2
* Application Load Balancer
* RDS

Provides secure communication between infrastructure components.

---

## Compute Module

Deploys:

* Amazon EC2
* IAM Instance Profile
* IAM Role
* User Data Script

Automatically installs the web server during provisioning.

---

## S3 Module

Creates:

* Versioned S3 Bucket
* Server Side Encryption
* Lifecycle Policies
* Public Access Block

Acts as the backup storage location.

---

## ALB Module

Creates:

* Application Load Balancer
* Target Group
* Listener

Distributes incoming traffic across the application.

---

## RDS Module

Deploys:

* MySQL Database
* DB Subnet Group
* Security Group

Database remains isolated inside private subnets.

---

## CloudWatch Module

Creates:

* CPU Alarm
* Status Check Alarm

Monitors EC2 health continuously.

---

## SNS Module

Creates:

* SNS Topic
* Email Subscription

Used to notify administrators whenever alarms are triggered.

---

## Lambda Module

Responsible for automated recovery.

Functions:

* Receives SNS Events
* Parses CloudWatch Alarm
* Validates Alarm State
* Reboots EC2 Instance

---

## EBS Snapshot Module

Automatically creates daily EBS snapshots.

Components:

* Lambda
* IAM Role
* EventBridge Schedule

---

## RDS Snapshot Module

Automatically creates daily RDS snapshots.

Components:

* Lambda
* IAM Role
* EventBridge Schedule

---

# 🔄 Infrastructure Deployment Workflow

```
Write Terraform Code
        │
        ▼
terraform init
        │
        ▼
terraform validate
        │
        ▼
terraform fmt
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
AWS Infrastructure Created
        │
        ▼
Application Deployment
        │
        ▼
Infrastructure Monitoring Begins
```

---

# 🔁 Disaster Recovery Workflow

```
User Traffic
      │
      ▼
Application Load Balancer
      │
      ▼
EC2 Web Server
      │
      ▼
CloudWatch Monitoring
      │
      ▼
CPU / Status Alarm
      │
      ▼
SNS Notification
      │
      ▼
Lambda Function
      │
      ▼
EC2 Recovery Action
      │
      ▼
Application Restored
```

---

# 💾 Backup Workflow

```
Application
      │
      ▼
Amazon EBS Volume
      │
      ▼
Lambda Snapshot Function
      │
      ▼
Daily EBS Snapshot
```

---

# 🗄 Database Backup Workflow

```
Amazon RDS
      │
      ▼
Lambda Snapshot Function
      │
      ▼
Daily RDS Snapshot
```

---

# 🌍 Cross Region Replication Workflow

```
Primary S3 Bucket
(Mumbai)

        │

Object Uploaded

        │

Automatic Replication

        │

Secondary S3 Bucket
(Hyderabad)

        │

Disaster Recovery Backup Ready
```

---

# 🚀 Deployment Procedure

### Step 1

Deploy Primary Infrastructure

```bash
cd terraform

terraform init

terraform validate

terraform plan

terraform apply
```

---

### Step 2

Deploy Disaster Recovery Infrastructure

```bash
cd terraform-dr

terraform init

terraform validate

terraform plan

terraform apply
```

---

### Step 3

Deploy Global Infrastructure

```bash
cd terraform-global

terraform init

terraform validate

terraform plan

terraform apply
```

---

# 🔒 Security Best Practices

* Infrastructure deployed using Terraform
* IAM Least Privilege Policies
* Encrypted S3 Storage
* Versioned Backups
* Private Database Subnets
* Security Groups
* Server Side Encryption
* Public Access Block Enabled
* Automated Monitoring
* Automatic Recovery
* Automated Backup Strategy

---
# 🧪 Testing & Validation

The project was tested after deploying all Terraform modules in AWS.

---

## ✅ Infrastructure Deployment

| Test                              | Status   |
| --------------------------------- | -------- |
| Terraform Init                    | ✅ Passed |
| Terraform Validate                | ✅ Passed |
| Terraform Plan                    | ✅ Passed |
| Terraform Apply                   | ✅ Passed |
| Primary Infrastructure Deployment | ✅ Passed |
| Disaster Recovery Deployment      | ✅ Passed |
| Global Infrastructure Deployment  | ✅ Passed |

---

## ✅ Networking

* VPC Created
* Public Subnets Created
* Private Subnets Created
* Route Tables Configured
* Internet Gateway Attached
* Security Groups Applied

Status:

**✅ Successful**

---

## ✅ Compute

* EC2 Instance Provisioned
* IAM Role Attached
* User Data Executed
* NGINX Installed
* Web Server Running

Status:

**✅ Successful**

---

## ✅ Application Load Balancer

* ALB Created
* Target Group Healthy
* Listener Configured
* EC2 Registered

Status:

**✅ Successful**

---

## ✅ Amazon RDS

* MySQL Database Created
* Database Accessible from EC2
* Private Subnets Working

Status:

**✅ Successful**

---

## ✅ Amazon S3

Verified:

* Bucket Created
* Versioning Enabled
* Encryption Enabled
* Public Access Block Enabled

Status:

**✅ Successful**

---

## ✅ Cross Region Replication

Primary Bucket

↓

Replication Enabled

↓

Secondary Bucket

↓

Object Successfully Replicated

Status:

**✅ Successful**

---

## ✅ CloudWatch Monitoring

Created:

* CPU Alarm
* Status Check Alarm

Both alarms were successfully deployed and linked to Amazon SNS.

Status:

**✅ Successful**

---

## ✅ Amazon SNS

Verified:

* SNS Topic Created
* Email Subscription Confirmed
* Email Notifications Successfully Received

Status:

**✅ Successful**

---

## ✅ AWS Lambda

Implemented:

* Auto Recovery Lambda
* EBS Snapshot Lambda
* RDS Snapshot Lambda

Verified:

* Lambda Deployment Successful
* IAM Permissions Applied
* Environment Variables Configured

Status:

**✅ Successful**

---

## ✅ Automatic Backups

Verified:

* Daily EBS Snapshot Scheduler
* Daily RDS Snapshot Scheduler

Status:

**✅ Successful**

---

# 🔬 Recovery Test

The following recovery workflow was successfully validated.

```
CloudWatch Alarm

        │

        ▼

Amazon SNS

        │

        ▼

Email Notification Received

        │

        ▼

Lambda Triggered

        │

        ▼

Recovery Logic Executed

        │

        ▼

Application Restored
```

---

# 📸 Project Screenshots

Include screenshots for the following sections.

```
screenshots/

├── architecture.png

├── terraform-apply.png

├── aws-console.png

├── ec2.png

├── alb.png

├── cloudwatch.png

├── sns.png

├── lambda.png

├── rds.png

├── s3.png

├── replication.png

├── backup.png
```

---

# 💰 Cost Optimization

The project was intentionally designed to minimize AWS costs.

Techniques used:

* Free Tier eligible resources wherever possible
* Small EC2 instance types
* Minimal RDS storage
* Versioned S3 buckets
* Optional NAT Gateway
* Infrastructure destroyed after testing
* Terraform used for complete resource lifecycle management

---

# 📈 Future Enhancements

Future improvements planned for this project include:

* Route 53 Automated Failover
* AWS Global Accelerator
* Multi-Region Application Load Balancer
* Auto Scaling Groups
* ECS Fargate Deployment
* Amazon EKS Integration
* AWS Backup Vault
* AWS Systems Manager Automation
* CloudTrail Logging
* AWS Config Compliance
* WAF Integration
* GuardDuty Integration
* CI/CD Pipeline using GitHub Actions
* Terraform Remote Backend
* DynamoDB State Locking

---

# 🎓 Learning Outcomes

This project provided practical experience with:

* Enterprise AWS Architecture
* Disaster Recovery Planning
* Infrastructure as Code
* Terraform Modules
* AWS Networking
* High Availability Design
* Monitoring & Alerting
* Backup Automation
* Cloud Security
* IAM Policy Management
* AWS Lambda Automation
* Cross Region Replication
* Cloud Cost Optimization
* Production Deployment Practices

---

# 📚 Tech Stack

### Cloud

* Amazon Web Services (AWS)

### Infrastructure as Code

* Terraform

### Programming

* Python

### Monitoring

* Amazon CloudWatch

### Notifications

* Amazon SNS

### Automation

* AWS Lambda

### Database

* Amazon RDS MySQL

### Compute

* Amazon EC2

### Storage

* Amazon S3

### Networking

* VPC
* Internet Gateway
* Route Tables
* Security Groups
* Application Load Balancer

---

# 🏆 Resume Highlights

* Designed and deployed a complete Disaster Recovery platform using Terraform and AWS.
* Built reusable Terraform modules following Infrastructure as Code best practices.
* Implemented automated EC2 recovery using CloudWatch, SNS, and AWS Lambda.
* Configured automatic EBS and RDS snapshot scheduling.
* Implemented cross-region S3 replication between Mumbai and Hyderabad regions.
* Designed secure networking using VPC, Security Groups, private subnets, and IAM roles.
* Demonstrated enterprise disaster recovery architecture with automated monitoring and backup workflows.

---

# 🤝 Contributing

Contributions, improvements, and suggestions are welcome.

If you find any issues or have ideas to improve the project, feel free to fork the repository and submit a pull request.

---

# 📄 License

This project is developed for educational and portfolio purposes.

---

# 👨‍💻 Author

## **Nikhil Chamyal**


Cloud Engineer | DevOps Engineer | AWS | Terraform | Docker | Kubernetes | Jenkins | Python



---

# ⭐ Support

If you found this project useful, consider giving it a ⭐ on GitHub.

It helps others discover the project and supports my work.

---

## Thank You!

Thank you for taking the time to explore **CloudShield-DR**.

This project represents a practical implementation of cloud infrastructure automation, disaster recovery planning, monitoring, backup automation, and enterprise AWS architecture using Terraform.

**Happy Learning! 🚀**
