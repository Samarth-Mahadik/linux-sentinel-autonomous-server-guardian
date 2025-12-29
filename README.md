# 🚀 Linux Sentinel – Autonomous Linux Server Guardian

Linux Sentinel is a **production-grade, autonomous Linux monitoring and self-healing system** designed to behave like a real Linux system administrator — not just a script.

It continuously monitors system health, detects abnormal behavior, automatically takes corrective action, and maintains forensic-grade logs for visibility and audits.

---

## 🧩 Problem Statement

In real production environments, Linux servers face constant challenges:

- Disk exhaustion leading to application downtime  
- Services crashing unexpectedly  
- Sudden memory spikes due to leaks or runaway processes  
- Security threats such as SSH brute-force attacks  

Manual monitoring is **reactive, slow, and risky**, especially in environments without 24×7 administrators.

---

## 💡 Solution

**Linux Sentinel** is a **self-monitoring and self-healing Linux system** that:

- Continuously observes system health
- Detects anomalies using admin-style logic
- Automatically resolves common failures
- Logs every action with reason and timestamp
- Alerts administrators in a human-readable format

This system reduces downtime, manual intervention, and operational risk.

---

## 🏗️ Architecture Overview

<img width="1920" height="916" alt="image 2" src="https://github.com/user-attachments/assets/ae150230-ce26-4c61-a889-32ca1502881b" />

**Flow:**
Monitoring Modules → Decision Engine → Self-Healing Actions → Alerts & Logs

---

## ⚙️ Core Features

- **Intelligent Health Monitoring**  
  Real-time monitoring of CPU, memory, disk usage, and critical services

- **Autonomous Self-Healing Engine**  
  Automatically restarts failed services and cleans disk space before outages occur

- **Security Threat Detection**  
  Identifies suspicious SSH activity and logs potential brute-force attempts

- **Forensic-Grade Logging**  
  All actions are logged with timestamps and reasons for auditing and analysis

- **Admin-Aware Alerting**  
  Generates clear, human-readable alerts instead of raw metrics

---

## 🧰 Tech Stack

- **Linux**
- **Bash Scripting**
- **systemd**
- **cron**
- **journalctl & log analysis**
- **Firewall (iptables / ufw)**
- **Process & memory management**

> No external monitoring tools — pure Linux administration.

---

## 🔄 Execution Flow

1. Monitoring modules collect system metrics  
2. Decision engine evaluates thresholds and behavior  
3. Self-healing actions are triggered when required  
4. Alerts and logs are generated for administrator visibility  

---

## Code Quality & Validation
All Bash scripts were statically analyzed and validated using **ShellCheck**
on **Amazon Linux 2023** to ensure adherence to Bash best practices and
production-grade scripting standards. ShellCheck was executed using the `-x` flag to correctly analyze the modular,
multi-script architecture of the project.

---

## ▶️ How to Run

```bash
# Make scripts executable
chmod +x core/sentinel.sh modules/*.sh alerts/*.sh

# Schedule execution every 5 minutes
crontab -e
*/5 * * * * /opt/linux_sentinel/core/sentinel.sh
🧪 Real-World Use Cases
Startup servers without dedicated Linux administrators

Production Linux servers requiring high availability

Cloud virtual machines (AWS / Azure / GCP)

Learning and demonstrating system administrator mindset

🧠 Engineering Takeaway
This project represents a shift from:

❌ Running Linux commands
to
✅ Designing autonomous, self-healing Linux systems

It demonstrates real-world Linux administration, automation, and production thinking.

📌 Author
Samarth Mahadik
Linux | Cloud | DevOps

Built to solve real problems — not to follow tutorials.
