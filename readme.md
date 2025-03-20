# Simple Terraform Azure Infrastructure Project

## Overview
This is a simple Terraform project is designed to provision and manage infrastructure on **Microsoft Azure**. It follows a modular approach and consists of the following key components:

- **Networking Module**: Sets up virtual networks, subnets, and security groups.
- **Compute Module**: Provisions virtual machines and related resources.
- **Database Module**: Deploys database services such as Azure SQL.

The principal entry point for Terraform execution is the **`main.tf`** file, which orchestrates the deployment by calling these modules.

## Project Structure
```
terraform-azure-project/
│   ├── resource-groupe/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── database/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── main.tf
│── README.md
```

## Requirements
- Terraform v1.11.2
- Azure CLI and logged in
- An active Azure subscription

## Usage
### 1️⃣ Initialize Terraform
```sh
terraform init
```
### 2️⃣ Plan Infrastructure Changes
```sh
terraform plan 
```
### 3️⃣ Apply Changes to Deploy Resources
```sh
terraform apply -auto-approve
```
### 4️⃣ Destroy Infrastructure (if needed)
```sh
terraform destroy -auto-approve
```

## Modules Breakdown
### 🏢 Networking Module (`modules/networking`)
- Creates Virtual Networks (VNet)
- Defines Subnets
- Sets up Network Security Groups (NSG)

### 🖥️ Compute Module (`modules/compute`)
- Deploys Virtual Machines (VMs)
- Configures VM networking and security rules
- Attaches storage and managed disks

### 🗄️ Database Module (`modules/database`)  

- Provisions Azure SQL Database or Cosmos DB
- Configures security policies and access rules

## Diagram
Below is a high-level architecture diagram of the infrastructure:

![Screenshot_2](https://github.com/user-attachments/assets/b68eac32-7237-4158-9f3f-a3456d0c0bec)


