# 🏆 Day 14: Terraform Best Practices & Style
> **Topic:** Writing Production-Grade Code

---

## 🎯 Today's Mission
It's not just about "working"—it's about "maintainability." Today we learn the **Standard Structure** used in 99% of professional companies. We will refactor our messy code into a beautiful, standardized project.

---

## 📁 The Professional File Structure
```text
📂 project
 ┣ 📜 provider.tf    # Provider & Version constraints
 ┣ 📜 main.tf        # The Core Logic
 ┣ 📜 variables.tf   # All Inputs defined here
 ┣ 📜 outputs.tf     # All Outputs defined here
 ┣ 📜 locals.tf      # Internal variables/Logic
 ┗ 📜 terraform.tfvars # Actual values for variables
```

---

## 🔍 The "Senior" Checklist
- [ ] **Formatting:** Always run `terraform fmt` before committing.
- [ ] **Validation:** Always run `terraform validate` to catch syntax errors.
- [ ] **Descriptions:** Every variable must have a `description` field.
- [ ] **Tags:** Use `locals` to define common tags (Owner, Env, Project) and apply them to everything.

---

## 🧠 Senior DevOps Insight
- **Hard-coding is a Sin:** Never hardcode an AMI ID or a Subnet ID. Always use **Data Sources** or **Variables**.
- **Version Constraints:** Always lock your Terraform and Provider versions. This prevents your code from breaking when a new version is released.

---
<p align="center">
  <b>Graduation progress: Day 14/20 ✅</b>
</p>
