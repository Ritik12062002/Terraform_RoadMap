# 🚀 Terraform & AWS Interview Prep: 1 Year Experience (50+ Questions)
> **Focus:** Networking, State Management, Reusability, and Security

---

## 🌐 Section 1: VPC & Advanced Networking

### 1. Explain the VPC components in detail.
**Answer:** 
- **Subnets:** Segments of IP ranges.
- **Route Tables:** Routing logic.
- **Internet Gateway (IGW):** Public entry.
- **NAT Gateway:** Outbound traffic for private subnets.
- **VPC Peering:** Connecting two VPCs.
- **Endpoints (S3/Interface):** Accessing AWS services without internet.

### 2. Difference between Security Groups and NACLs?
**Answer:** 
- **Security Group:** Stateful (Return traffic allowed), attached to Instance, Allow rules only.
- **NACL:** Stateless (Must allow return traffic), attached to Subnet, Allow/Deny rules.

### 3. What is VPC Peering?
**Answer:** A networking connection between two VPCs that enables you to route traffic between them using private IPv4 or IPv6 addresses.

### 4. What are VPC Endpoints?
**Answer:** They allow you to privately connect your VPC to supported AWS services and VPC endpoint services powered by PrivateLink. They don't require an IGW or NAT.

### 5. What is the difference between an Interface Endpoint and a Gateway Endpoint?
**Answer:** 
- **Gateway Endpoint:** Free, works for S3 and DynamoDB only.
- **Interface Endpoint:** Costs money, uses PrivateLink, works for most other services.

### 6. How do you design a high-availability VPC?
**Answer:** By deploying subnets across at least two Availability Zones (AZs) and using a Multi-AZ NAT Gateway or NAT instances.

### 7. What is a Transit Gateway?
**Answer:** A network transit hub that you can use to connect your VPCs and your on-premises networks.

---

## 💾 Section 2: Terraform State & Backends

### 8. Why is the local state file a problem for teams?
**Answer:** 
- **Corruption:** Two people editing at once.
- **Security:** Secrets in plain text on local disk.
- **Inconsistency:** Local state doesn't match teammate's state.

### 9. Explain Remote State with S3 and DynamoDB.
**Answer:** S3 stores the `.tfstate` file centrally. DynamoDB provides a "Lock" mechanism. When one person runs `apply`, Terraform writes a record to DynamoDB. If another person tries to run `apply`, Terraform sees the lock and stops them.

### 10. What is 'terraform state list'?
**Answer:** It lists all the resources currently tracked in the state file.

### 11. What is 'terraform state show <resource_name>'?
**Answer:** Shows detailed attributes of a specific resource as recorded in the state.

### 12. What is 'terraform state mv'?
**Answer:** Used to rename a resource in the state without destroying and recreating the actual resource in AWS.

### 13. What is 'terraform state rm'?
**Answer:** Removes a resource from the state file. Terraform stops managing it, but the resource still exists in AWS.

### 14. What is 'terraform refresh'?
**Answer:** Updates the state file with the real-world status of resources. It doesn't change infrastructure, just the state "memory".

### 15. What is 'terraform taint'?
**Answer:** Marks a resource for recreation on the next `apply`. (Deprecated in favor of `-replace` flag).

### 16. What is 'terraform import'?
**Answer:** Brings existing AWS resources into Terraform management.

### 17. How do you handle State file security?
**Answer:** 
- Enable S3 Bucket Versioning.
- Enable S3 Encryption at rest.
- Use IAM policies to restrict who can read the bucket.

---

## 📦 Section 3: Variables, Locals & Modules

### 18. What is the order of precedence for variables?
**Answer:** (Highest to Lowest)
1. `-var` or `-var-file` flags.
2. `*.auto.tfvars`.
3. `terraform.tfvars`.
4. Environment variables (`TF_VAR_...`).
5. Default values in `variables.tf`.

### 19. What are 'Locals' and when should you use them?
**Answer:** Used for expressions that are repeated many times. Example: Merging common tags with specific resource tags.

### 20. What is a Module and why is it important?
**Answer:** A reusable package of Terraform code. It promotes the DRY (Don't Repeat Yourself) principle.

### 21. What is the 'source' argument in a module?
**Answer:** Defines where the module code is located (local path, GitHub, Terraform Registry).

### 22. What are Module Outputs?
**Answer:** How a module returns information to the calling (root) code.

### 23. What is the difference between a Root Module and a Child Module?
**Answer:** Root module is where you run `apply`. Child modules are called by the root module.

---

## 🛡️ Section 4: IAM & Security

### 24. What is an IAM Role vs an IAM User?
**Answer:** 
- **User:** Permanent credentials for a person/app.
- **Role:** Temporary credentials assumed by a service (like EC2) or a user.

### 25. What is a Trust Policy?
**Answer:** Defines which principal (service/account) can assume an IAM Role.

### 26. What is an IAM Instance Profile?
**Answer:** A container for an IAM role that you can use to pass role information to an EC2 instance.

### 27. What is the "Principle of Least Privilege"?
**Answer:** Giving a user or service only the exact permissions they need to perform their task, and nothing more.

---

## 💡 Section 5: Scenario & Logic

### 28. "How do you upgrade a Terraform provider version?"
**Answer:** Change the version constraint in your code and run `terraform init -upgrade`.

### 29. "What is Drift and how do you fix it?"
**Answer:** Drift is when manual changes happen in the AWS Console. Fix it by running `terraform apply`, which will revert the changes to match the code.

### 30. "What is 'terraform validate' used for?"
**Answer:** To check if the code is syntactically correct and internally consistent before running `plan`.

### 31. "How do you pass a variable from a module back to the main code?"
**Answer:** Define an `output` in the module and reference it using `module.<name>.<output_name>`.

### 32. "Can you have multiple VPCs in one account?"
**Answer:** Yes, up to 5 per region (soft limit).

### 33. "How do you handle sensitive data in variables?"
**Answer:** Use the `sensitive = true` flag in the variable definition to hide it from terminal output.

### 34. What is the use of `terraform.tfvars`?
**Answer:** To store actual values of variables for a specific environment.

### 35. What is a 'Backend' block?
**Answer:** Configuration inside the `terraform {}` block that defines where the state is stored.

### 36. What is 'terraform workspace list'?
**Answer:** Lists all existing workspaces.

### 37. What is the benefit of using `terraform fmt`?
**Answer:** Code readability and consistency across a team.

### 38. "What happens if S3 state is deleted but resources exist?"
**Answer:** Terraform becomes "blind". You must either `import` all resources back or recreate them.

### 39. What is `terraform output` command?
**Answer:** Extracts and displays the values of output variables from the state file.

### 40. "Can I manage multiple AWS accounts with one Terraform project?"
**Answer:** Yes, by using multiple `provider` blocks with `alias`.

### 41. What is an `Attribute` in Terraform?
**Answer:** Data exported by a resource after creation (e.g., `id`, `arn`).

### 42. Difference between `terraform plan` and `terraform apply -refresh-only`?
**Answer:** `plan` shows changes; `-refresh-only` updates the state file to match reality without proposing changes.

### 43. What is an `Elastic IP`?
**Answer:** A static IPv4 address designed for dynamic cloud computing.

### 44. What is a `Target Group` in ALB?
**Answer:** A group of resources that the load balancer routes requests to.

### 45. What is a `Launch Template` vs `Launch Configuration`?
**Answer:** Launch Template is newer, supports versioning, and is recommended by AWS.

### 46. What is `user_data_base64`?
**Answer:** Passing the bootstrap script as a base64 encoded string.

### 47. "How do you handle provider version locking?"
**Answer:** Using the `required_providers` block with version constraints.

### 48. What is `terraform.lock.hcl`?
**Answer:** A file that locks the exact version and checksum of the provider plugins used.

### 49. What is a `Resource Dependency`?
**Answer:** When Resource B needs Resource A's output to be created.

### 50. What is `count.index`?
**Answer:** The current index number in a `count` loop.

### 51. "Can you change the region of an existing resource?"
**Answer:** Usually no. Most resources must be destroyed and recreated in the new region.

### 52. What is `terraform graph`?
**Answer:** Generates a visual representation of your resource dependencies.

---
<p align="center">
  <b>1 Year of experience means you understand 'How the team works' and 'How the network flows'.</b>
</p>
