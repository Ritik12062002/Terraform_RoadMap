# 🤖 Day 16: Automated CI/CD with GitHub Actions
> **Topic:** The Speed of Continuous Integration

---

## 🎯 1. The "Why" - Why are we doing this?
Humans are slow and make mistakes. If you forget to run `terraform fmt` or `plan`, you might break the infrastructure. A **CI/CD Pipeline** acts as a robot quality controller. It automatically tests and deploys your code every time you save it.

**Real World Use Case:** In a big company, 50 developers might push code in one day. The pipeline ensures that "Main" branch is always safe and correctly deployed, so no one has to do it manually.

---

## 🛠️ 2. Core Concepts & Definitions
- **Workflows:** A set of instructions for the robot (GitHub Actions).
- **Runners:** The remote servers that actually execute your commands (e.g., Ubuntu).
- **Secrets:** Environment variables where you store your `AWS_ACCESS_KEY` safely (inside GitHub settings).
- **Plan vs Apply:** The pipeline usually runs `plan` on pull requests and `apply` only when the code is merged.

---

## 🔍 3. Line-by-Line Code Explanation (`.github/workflows/terraform.yml`)

```yaml
on:
  push:
    branches: [ main ]
```
- **Trigger:** Whenever someone pushes code directly to the "main" branch, the robot starts.

```yaml
jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
```
- **Runs-on:** We are using a fresh Linux machine provided by GitHub.
- **Checkout:** The robot "Downloads" your code from the repo onto its own machine.

```yaml
      - name: Terraform Init
        run: terraform init
      - name: Terraform Plan
        run: terraform plan
```
- **Execution:** The robot runs the exact same commands you practiced in the labs.

---

## 🏗️ 4. The Industry Standard "GitOps" Workflow
```mermaid
graph LR
    ritik[👨‍💻 ritik pushes code] -- Git Push --> GH[GitHub Repo]
    GH -- Trigger PR --> GHP[Plan Pipeline]
    GHP -- Post Results --> PR[Review Plan]
    PR -- ✅ Merge --> GHA[Apply Pipeline]
    GHA -- Deploy --> AWS[AWS Cloud]
```

---

## 🧠 5. Senior DevOps Insight
- **Terraform Cloud:** If you don't want to manage runners, Terraform Cloud is the best alternative. It handles the "Apply" button and state locking perfectly in the browser.
- **Security:** Use **OIDC (OpenID Connect)** instead of Access Keys in your GitHub Actions for better security.

---

### 🛠️ Hands-on Tasks:
- [ ] Connect your repository to GitHub.
- [ ] Add your `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` to **GitHub Secrets** (Settings -> Secrets).
- [ ] Push a small change.
- [ ] **Verification:** Go to the "Actions" tab in GitHub. Do you see the robot running your code?

---
<p align="center">
  <b>Graduation progress: Day 16/20 ✅</b>
</p>
