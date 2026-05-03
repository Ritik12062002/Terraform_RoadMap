# 🧙‍♂️ Terraform & AWS Interview Prep: 2 Year Experience (50+ Questions)
> **Focus:** Architecture, Logic, Automation, Security, and Troubleshooting

---

## 🏗️ Section 1: Advanced Terraform Logic & Logic

### 1. Deep dive: 'count' vs 'for_each'. When to use which?
**Answer:** 
- **Count:** Use when you want multiple IDENTICAL resources (e.g., 5 identical web servers).
- **For_Each:** Use when resources have unique configurations (e.g., users with different names, or subnets with different CIDRs). `for_each` is index-independent, making it safer for deletions.

### 2. Explain 'Dynamic Blocks' with a real-world example.
**Answer:** Used to generate multiple nested blocks within a resource. 
*Example:* A Security Group that needs 20 different `ingress` rules based on a map of ports and descriptions.

### 3. What are 'Locals' and how do they differ from Variables in a complex project?
**Answer:** Locals are for internal computation. In complex projects, you might use locals to merge multiple maps of tags, or to truncate strings to meet AWS naming limits. They keep the `main.tf` clean.

### 4. How do you use 'Conditionals' in Terraform?
**Answer:** Using the ternary operator: `count = var.create_resource ? 1 : 0`.

### 5. What is 'Terragrunt' and why do people use it?
**Answer:** A thin wrapper for Terraform that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state.

### 6. Explain 'Terraform Import' process in detail.
**Answer:** 
1. Write the `resource` code in your `.tf` file.
2. Run `terraform import <address> <id>`.
3. Run `terraform plan` to see if your code matches the imported state. 
4. Adjust code until `plan` shows "No changes".

### 7. What is 'Terraform Taint' vs '-replace'?
**Answer:** `taint` (deprecated) marks a resource for recreation. The `-replace` flag in `terraform apply` does this in one step without modifying the state file permanently before the run.

### 8. How do you handle multi-cloud deployments with Terraform?
**Answer:** By using multiple provider blocks (AWS, Azure) and referencing them in modules. However, resource types are different, so you usually need cloud-specific modules.

---

## 🏛️ Section 2: Architecture & Scalability

### 9. Explain a production-grade 3-tier architecture design.
**Answer:** 
- **Public Subnets:** ALB, NAT Gateway, Bastion Host.
- **Private Subnets (App):** EC2 Auto Scaling Group.
- **Private Subnets (DB):** Multi-AZ RDS Cluster.
- **Security:** Security Group chaining (ALB -> App -> DB).

### 10. How do you handle Disaster Recovery (DR) in AWS with Terraform?
**Answer:** 
- **Multi-Region:** Deploy code to two regions.
- **Route53 Failover:** Health check pointing to secondary region.
- **RDS Read Replicas:** Cross-region replication.

### 11. What is Blue-Green Deployment?
**Answer:** Having two identical production environments (Blue and Green). Only one is live. You deploy new code to the idle one, test it, and then switch Route53 traffic.

### 12. How do you secure an S3 bucket used for website hosting?
**Answer:** 
- Use OAI (Origin Access Identity) with CloudFront.
- Block all public access on the bucket.
- Allow only CloudFront to read from the bucket policy.

### 13. What is AWS Organizations and Service Control Policies (SCPs)?
**Answer:** Organizations allow managing multiple AWS accounts. SCPs allow you to set maximum permissions across all accounts in an Org (e.g., "Nobody can use the Paris region").

### 14. Explain the difference between Application, Network, and Classic Load Balancers.
**Answer:** 
- **ALB:** Layer 7 (HTTP/Path/Header).
- **NLB:** Layer 4 (TCP/UDP, ultra-high performance).
- **Classic:** Legacy, not recommended for new projects.

---

## 🤖 Section 3: CI/CD & Automation

### 15. Describe a full GitOps pipeline for Terraform.
**Answer:** 
- **Branching:** Feature branch -> Pull Request.
- **Linting:** `tflint`, `terraform fmt -check`.
- **Security Scan:** `tfsec` or `checkov`.
- **Plan:** `terraform plan` output posted to PR comments.
- **Manual Approval:** Senior review.
- **Merge:** Triggers `terraform apply` to production.

### 16. How do you manage secrets in a CI/CD pipeline?
**Answer:** 
- Use GitHub Secrets / GitLab CI Variables.
- Use **OIDC** (OpenID Connect) so the pipeline doesn't need long-term AWS keys.
- Use HashiCorp Vault or AWS Secrets Manager.

### 17. What is 'State Locking' and what happens if a pipeline crashes?
**Answer:** Prevents concurrent runs. If a pipeline crashes, the lock might stay in DynamoDB. You must manually run `terraform force-unlock <lock_id>`.

---

## 🐞 Section 4: Troubleshooting & State Manipulation

### 18. "Plan shows 50 resources to be recreated, but I only changed a tag. Why?"
**Answer:** Check if you changed a parameter that "Forces Replacement" (e.g., renaming a DB instance or changing a VPC CIDR). Also, check if you accidentally changed a module version that has breaking changes.

### 19. How do you refactor resources into a module without destroying them?
**Answer:** Use the `moved` block (introduced in TF 1.1) to tell Terraform that a resource has changed its address (e.g., from `aws_instance.web` to `module.web.aws_instance.server`).

### 20. What is 'terraform state pull' and 'push'?
**Answer:** Used to manually download the JSON state from S3 for manual editing (extreme cases) and then uploading it back.

---

## 💡 Section 5: Scenario & Advanced Logic

### 21. "Your company has 100 AWS accounts. How do you manage them efficiently?"
**Answer:** Use **Terraform Landing Zones** or **AWS Control Tower** with Terraform. Centralize your modules in a Private Registry.

### 22. "A developer deleted the S3 state bucket. How do you recover?"
**Answer:** 
1. If versioning was on, restore the previous version.
2. If no backup, use `terraform import` to rebuild the state for every single resource (extremely tedious).

### 23. "Explain 'Inplace' vs 'Destroy/Create' updates."
**Answer:** Inplace means AWS API can update the setting (e.g., changing tags). Destroy/Create means the setting is fundamental (e.g., AMI change or Subnet change).

### 24. "How do you handle provider alias?"
**Answer:** Use `alias` for managing resources in different regions or different AWS accounts within the same project.

### 25. What is the use of `lifecycle` block?
**Answer:** 
- `create_before_destroy`: Zero downtime updates.
- `prevent_destroy`: Safety net for DBs.
- `ignore_changes`: Useful if external tools modify the resource (like ASG scaling).

### 26. What is `terraform state rm` and when to use it?
**Answer:** When you want to stop managing a resource with Terraform but keep it running in AWS.

### 27. "How do you optimize Terraform performance for 1,000+ resources?"
**Answer:** 
- Split code into smaller state files (modularize).
- Use `-refresh=false` if you know the state is up to date.
- Use `-target` (not recommended for daily use, but good for isolated fixes).

### 28. What is `tfvars.json`?
**Answer:** Using JSON format for variable values, useful for automated scripts.

### 29. "How do you test Terraform modules?"
**Answer:** 
- `terraform test` (native in 1.6+).
- **Kitchen-Terraform** or **Terratest** (Go-based).

### 30. What is `pre-commit` hook for Terraform?
**Answer:** Automatically running `fmt` and `validate` before every `git commit`.

### 31. Difference between `depends_on` and `data source` dependency?
**Answer:** `depends_on` is a hard order of creation. Data source dependency is implicit; Terraform waits for the resource to exist to fetch its data.

### 32. "How do you scale a database in RDS without downtime?"
**Answer:** Use **RDS Multi-AZ**. Scale the standby first, then failover, then scale the new standby.

### 33. What is `Global Accelerator`?
**Answer:** Improving latency by using the AWS Global Network instead of the public internet.

### 34. What is `CloudFront OAI`?
**Answer:** Restricting S3 access only to CloudFront.

### 35. "How do you handle 'Error: Resource already exists' during apply?"
**Answer:** This happens when state and AWS are out of sync. Use `terraform import` to map the existing resource to your code.

### 36. What is `module versioning` in Registry?
**Answer:** Using Semantic Versioning (`~> 1.0`) to allow bug fixes but prevent breaking changes.

### 37. "Explain 'S3 Cross-Region Replication' setup via Terraform."
**Answer:** Requires IAM roles, source bucket configuration, and a destination bucket in another region.

### 38. What is `AWS Config`?
**Answer:** A service that enables you to assess, audit, and evaluate the configurations of your AWS resources.

### 39. "How do you implement 'Tfsec' in a pipeline?"
**Answer:** Run it as a step before `plan`. If it finds high-risk security issues, fail the build.

### 40. What is `Remote-exec` vs `Local-exec`?
**Answer:** 
- `Local-exec`: Runs a command on your laptop/runner.
- `Remote-exec`: Runs a command inside the EC2 instance via SSH/WinRM (not recommended for production).

### 41. What is `Cloud-init`?
**Answer:** Industry standard way to initialize cloud instances.

### 42. "How do you manage IAM policies for thousands of users?"
**Answer:** Use **IAM Groups** and attach policies to groups, not users.

### 43. What is `VPC Endpoint Service` (Endpoint Service)?
**Answer:** Allowing other AWS accounts to access your service via PrivateLink.

### 44. "Explain 'Terraform Cloud' workspaces vs CLI workspaces."
**Answer:** TF Cloud workspaces are like separate projects with their own variables and state. CLI workspaces are just different state files for the same code.

### 45. What is `Sensitive` data in outputs?
**Answer:** Marking an output as sensitive so it's hidden in the terminal and CI logs.

### 46. "How do you recover from a 'Corrupt State'?"
**Answer:** Use `terraform state pull`, fix the JSON manually, and `push` it back. (Dangerous!).

### 47. What is `Graphviz`?
**Answer:** Tool used to render the output of `terraform graph`.

### 48. "How do you handle 'API Rate Limiting' in Terraform?"
**Answer:** Increase the `-parallelism` limit or use a custom provider configuration with retries.

### 49. What is `provider-level tags`?
**Answer:** Setting tags at the provider level so every resource in that project gets them automatically (AWS Provider feature).

### 50. "What is the biggest challenge you've faced with Terraform?"
**Answer:** (Personal Answer Tip): Talk about a complex state migration, a massive drift issue, or setting up a multi-account landing zone.

---
<p align="center">
  <b>2 Years of experience is about 'Wisdom'. You know what breaks and how to build it right the first time.</b>
</p>
