# 🏗️ Day 11: Terraform Modules
> **Topic:** The Art of Reusable Code

---

## 🎯 Today's Mission
Stop repeating yourself. Today we refactor our code into **Modules**. This allows you to build a complex VPC once and deploy it for 10 different teams with just 5 lines of code.

---

## 🔍 Line-by-Line Code Breakdown

### 📦 Part 1: Calling the Module
```hcl
module "vpc" {
  source   = "./vpc-module"
  vpc_cidr = "10.0.0.0/16"
  env      = "prod"
}
```
- **source:** The path to your internal "package".
- **variables:** Passing inputs into the module (Input Variables).

### 📤 Part 2: Module Outputs
```hcl
output "vpc_id" {
  value = module.vpc.vpc_id
}
```
- **Access:** How the "Main" code gets information back from the "Module".

---

## 🏗️ Standard Module Folder Structure
```text
📂 vpc-module
 ┣ 📜 main.tf      # The Resources
 ┣ 📜 variables.tf # The Inputs
 ┗ 📜 outputs.tf   # The Results
```

---

## 🧠 Senior DevOps Insight
- **Versioning:** In production, we usually point `source` to a **Git Tag** (e.g., `v1.2.0`). This ensures your infrastructure doesn't change accidentally when someone updates the module.
- **Registry:** Check out the [official Terraform Registry](https://registry.terraform.io/) for high-quality community modules.

---
<p align="center">
  <b>Graduation progress: Day 11/20 ✅</b>
</p>
