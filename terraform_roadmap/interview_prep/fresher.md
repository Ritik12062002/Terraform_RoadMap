# 🎓 Terraform & AWS Interview Prep: Fresher Level (50+ Questions)
> **Focus:** Core Fundamentals, Terminology, and Basic Usage

---

## 🏗️ Section 1: Terraform Foundations

### 1. What is Infrastructure as Code (IaC)?
**Answer:** IaC is the process of managing and provisioning computer data centers through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.

### 2. What are the main advantages of using Terraform?
**Answer:** 
- Platform Agnostic (Works with AWS, Azure, GCP, etc.).
- Immutable Infrastructure.
- Declarative Style.
- State Management.
- Large Community and Provider support.

### 3. What is the difference between Declarative and Imperative tools?
**Answer:** 
- **Declarative (Terraform):** You define the "End State" (e.g., "I want 5 servers"), and the tool figures out how to get there.
- **Imperative (Ansible/Scripts):** You define the "Steps" (e.g., "Step 1: Create server, Step 2: Install nginx").

### 4. What is HCL?
**Answer:** HashiCorp Configuration Language. It is the language used to write Terraform code. It is designed to be human-readable and machine-friendly.

### 5. What is a "Provider" in Terraform?
**Answer:** A plugin that allows Terraform to interact with a specific API (like AWS, Azure, or even GitHub).

### 6. What is a "Resource" in Terraform?
**Answer:** The most important part of Terraform. It describes one or more infrastructure objects, such as a virtual network, a compute instance, or an S3 bucket.

### 7. What is a "Data Source" in Terraform?
**Answer:** It allows data to be fetched or computed for use elsewhere in a Terraform configuration (e.g., fetching an existing AMI ID or VPC ID).

### 8. Explain 'terraform init'.
**Answer:** It initializes a working directory containing Terraform configuration files. It downloads the necessary provider plugins.

### 9. Explain 'terraform plan'.
**Answer:** It creates an execution plan. It shows what actions Terraform will take to reach the desired state specified in the configuration files.

### 10. Explain 'terraform apply'.
**Answer:** It executes the actions proposed in a Terraform plan to create, update, or destroy infrastructure.

### 11. Explain 'terraform destroy'.
**Answer:** It is used to delete all the resources managed by the current Terraform project.

### 12. What is the 'terraform.tfstate' file?
**Answer:** It is a local file that stores the current state of your managed infrastructure. It maps your code to the real-world resources.

### 13. What is 'terraform validate'?
**Answer:** It checks the syntax and internal consistency of your configuration files.

### 14. What is 'terraform fmt'?
**Answer:** It automatically formats your code to follow the standard HCL style (indentation, alignment).

### 15. What are Input Variables?
**Answer:** They serve as parameters for a Terraform module, allowing you to customize the behavior without changing the code itself.

### 16. What are Output Values?
**Answer:** They are like return values for a Terraform module. They highlight specific information (like an IP address) after deployment.

### 17. What are Local Values (Locals)?
**Answer:** Internal names assigned to expressions. They help avoid repeating the same logic multiple times in your code.

### 18. What is a Module in Terraform?
**Answer:** A container for multiple resources that are used together. It allows you to group resources into a single unit.

### 19. What is the 'main.tf' file used for?
**Answer:** By convention, it is the primary entry point where resources are defined.

### 20. What is the 'variables.tf' file used for?
**Answer:** It is used to declare all the input variables used in the project.

---

## ☁️ Section 2: AWS Core Services (Basic)

### 21. What is AWS (Amazon Web Services)?
**Answer:** A comprehensive, evolving cloud computing platform provided by Amazon that includes a mixture of infrastructure as a service (IaaS), platform as a service (PaaS) and packaged software as a service (SaaS) offerings.

### 22. What is an EC2 Instance?
**Answer:** Elastic Compute Cloud. It is a virtual server in the AWS cloud.

### 23. What is an S3 Bucket?
**Answer:** Simple Storage Service. It is an object storage service for storing and retrieving any amount of data.

### 24. What is IAM (Identity and Access Management)?
**Answer:** A service that helps you securely control access to AWS resources. You use it to control who is authenticated (signed in) and authorized (has permissions) to use resources.

### 25. What is an IAM User?
**Answer:** An entity that you create in AWS to represent the person or application that uses it to interact with AWS.

### 26. What is an IAM Group?
**Answer:** A collection of IAM users. Groups let you specify permissions for multiple users.

### 27. What is an IAM Policy?
**Answer:** A JSON document that defines permissions. Policies can be attached to users, groups, or roles.

### 28. What is the AWS Free Tier?
**Answer:** A program that allows new customers to explore and try out AWS services free of charge up to specified limits for each service.

### 29. What is a Region in AWS?
**Answer:** A physical location around the world where AWS clusters data centers. (e.g., us-east-1).

### 30. What is an Availability Zone (AZ)?
**Answer:** One or more discrete data centers with redundant power, networking, and connectivity in an AWS Region.

### 31. What is a VPC (Virtual Private Cloud)?
**Answer:** A private, isolated section of the AWS Cloud where you can launch AWS resources in a virtual network that you define.

### 32. What is a Subnet?
**Answer:** A range of IP addresses in your VPC.

### 33. What is a Public Subnet?
**Answer:** A subnet that has a route to an Internet Gateway, allowing resources inside to talk to the internet.

### 34. What is a Private Subnet?
**Answer:** A subnet that does NOT have a direct route to an Internet Gateway.

### 35. What is an AMI (Amazon Machine Image)?
**Answer:** A template that contains the software configuration (operating system, application server, and applications) required to launch your instance.

---

## 🧪 Section 3: Scenario & Logic Questions

### 36. Scenario: "I want to change the instance type of my EC2. What will Terraform do?"
**Answer:** Terraform will compare the code with the state. It will see the change. Depending on the instance type and AWS rules, it will either update it in place or destroy the old instance and create a new one.

### 37. "Why should we use 'terraform plan' before 'apply'?"
**Answer:** To avoid accidental deletions or unwanted changes. It acts as a safety check.

### 38. "What happens if I delete a resource manually in the AWS Console?"
**Answer:** On the next 'terraform plan', Terraform will detect that the resource is missing (Drift) and propose to recreate it.

### 39. "Can I use Terraform to manage resources that were NOT created by Terraform?"
**Answer:** Yes, by using the `terraform import` command, but it requires manually writing the code for them first.

### 40. "What is the difference between a variable's 'default' and 'type'?"
**Answer:** `type` defines what kind of data is allowed (string, number, list). `default` is the value used if the user doesn't provide one.

### 41. What is an Output?
**Answer:** A way to show information after 'apply', like the Public IP of a server.

### 42. What is the '.terraform' folder?
**Answer:** A hidden folder created by `init` that stores the provider plugins and modules.

### 43. What is a 'Backend' in simple terms?
**Answer:** It's the place where Terraform stores its "Memory" (State file).

### 44. Can one Terraform file have multiple providers?
**Answer:** Yes, you can manage AWS and Azure in the same project.

### 45. What is an 'Argument' in HCL?
**Answer:** A key-value pair inside a resource block (e.g., `ami = "..."`).

### 46. What is a 'Block' in HCL?
**Answer:** A container for other content (e.g., `resource "..." { ... }`).

### 47. What is 'Interpolation' in Terraform?
**Answer:** The ability to reference one resource's attribute inside another (e.g., `vpc_id = aws_vpc.main.id`).

### 48. What is 'Dependency' in Terraform?
**Answer:** When one resource needs another to exist first. Terraform usually handles this automatically (Implicit Dependency).

### 49. What is 'Explicit Dependency'?
**Answer:** When you use the `depends_on` argument to tell Terraform exactly which resource to build first.

### 50. How do you stop Terraform from asking for variable values every time?
**Answer:** By using a `terraform.tfvars` file or environment variables.

### 51. What is 'Terraform Cloud'?
**Answer:** A managed service by HashiCorp that provides a UI, remote state management, and collaboration tools for teams.

### 52. What is the difference between 'Apply' and 'Plan'?
**Answer:** Plan is a "Suggestion"; Apply is the "Execution".

---
<p align="center">
  <b>Foundation is everything. Master these 50+ basics to crack any Fresher interview!</b>
</p>
