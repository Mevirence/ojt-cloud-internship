# Bastion Host Setup on AWS (with SSH Agent Forwarding on WSL)

A practical guide to setting up a bastion host on AWS and securely accessing a private EC2 instance using SSH agent forwarding — including common errors and how to fix them.

---

## What is a Bastion Host?

A **bastion host** (also called a jump box) is a regular EC2 instance that lives in a **public subnet** and acts as the single controlled entry point into your private network.

The name comes from military architecture — a bastion is a fortified point of a castle wall designed to face the outside and be heavily defended. In AWS, it serves the same purpose: one exposed, hardened entry point that protects everything behind it.

```
Internet
    ↓
Bastion Host (public subnet — exposed, restricted)
    ↓
Private EC2 (private subnet — hidden from internet)
```

### Real-World Use Cases

- **Database servers** — MySQL/PostgreSQL sits in a private subnet, developers reach it through the bastion
- **Backend app servers** — users hit a Load Balancer, developers SSH in through the bastion to debug
- **Internal admin tools** — dashboards and monitoring systems that should never be public-facing
- **Financial systems** — payment servers kept off the internet, with all access logged through the bastion

---

## Architecture Overview

| Resource | Subnet | Purpose |
|---|---|---|
| Bastion EC2 | Public subnet | Entry point, has public IP |
| Private EC2 | Private subnet | Actual workload, no public IP |
| Public SG | — | Allows SSH from your IP only |
| Private SG | — | Allows SSH from Public SG only |

---

## Prerequisites

- An existing VPC with a public and private subnet
- An Internet Gateway attached to the VPC
- A route table for the public subnet pointing `0.0.0.0/0` to the IGW
- AWS key pair (`.pem` file) stored locally
- WSL (Windows Subsystem for Linux) or any Linux terminal

---

## Step 1: Create Security Groups

### Public EC2 Security Group (Bastion)

| Direction | Type | Protocol | Port | Source |
|---|---|---|---|---|
| Inbound | SSH | TCP | 22 | My IP |
| Outbound | All traffic | All | All | 0.0.0.0/0 |

### Private EC2 Security Group

| Direction | Type | Protocol | Port | Source |
|---|---|---|---|---|
| Inbound | SSH | TCP | 22 | Public SG ID (e.g. `sg-0abc123...`) |
| Outbound | All traffic | All | All | 0.0.0.0/0 |

> **Important:** Set the private EC2's inbound SSH source to the **Security Group ID** of the public EC2, not a CIDR block. This ensures only instances wearing the public SG can reach it — nothing else.

---

## Step 2: Launch EC2 Instances

Launch two EC2 instances (Amazon Linux 2 or Ubuntu) using the **same key pair**:

- **Bastion EC2** — place in public subnet, attach Public SG, enable auto-assign public IP
- **Private EC2** — place in private subnet, attach Private SG, no public IP needed

Using the same key pair is important for agent forwarding to work correctly.

---

## Step 3: Prepare SSH Agent Forwarding (WSL)

SSH agent forwarding allows your local key to be "carried" into the bastion session, so you can hop into the private EC2 without storing your `.pem` file on the bastion.

### Fix key permissions

```bash
chmod 400 ~/.ssh/your-key.pem
```

### Start the SSH agent

```bash
eval $(ssh-agent -s)
```

Expected output:
```
Agent pid 1234
```

> The SSH agent only stays alive for your current WSL session. You'll need to run this again if you close and reopen WSL.

### Load your key into the agent

```bash
ssh-add ~/.ssh/your-key.pem
```

### Verify the key is loaded

```bash
ssh-add -l
```

You should see your key fingerprint listed. If it says `The agent has no identities`, repeat the `ssh-add` step.

---

## Step 4: SSH into the Bastion

```bash
ssh -A -i ~/.ssh/your-key.pem ubuntu@<bastion-public-ip>
```

- `-i` — specifies the key file
- `-A` — enables agent forwarding (carries your key into the session)

---

## Step 5: SSH into the Private EC2

Once inside the bastion, SSH into the private EC2 using its **private IP**:

```bash
ssh ubuntu@<private-ec2-private-ip>
```

No `-i` or `-A` needed here — the key is already forwarded from your local machine.

You can find the private IP in the AWS console: **EC2 → Instances → click private EC2 → Private IPv4 address**

---

## Common Errors and Fixes

### `Could not open a connection to your authentication agent`

The SSH agent isn't running. Fix:

```bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/your-key.pem
```

### `Permission denied (publickey)`

Either agent forwarding isn't active, or the key isn't loaded. Check:

```bash
ssh-add -l
```

If the agent has no identities, load the key. Then reconnect to the bastion with `-A` before trying the second hop again.

### `Warning: Unprotected private key file`

Your key permissions are too open. Fix:

```bash
chmod 400 ~/.ssh/your-key.pem
```

---

## Default Usernames by AMI

| AMI | Username |
|---|---|
| Amazon Linux 2 | `ec2-user` |
| Ubuntu | `ubuntu` |
| RHEL | `ec2-user` |

---

## Why Not Just Copy the `.pem` to the Bastion?

A common shortcut is to `scp` your key onto the bastion and use `-i` from there. This works but is considered **bad practice** because:

- Your private key now exists on a server exposed to the internet
- If the bastion is compromised, your key is too
- Agent forwarding achieves the same result without ever exposing the key

---

## Summary

```
Local WSL
  └── eval $(ssh-agent -s)        # start agent
  └── ssh-add ~/.ssh/key.pem      # load key
  └── ssh -A -i ~/.ssh/key.pem ubuntu@<bastion-ip>   # connect to bastion
        └── ssh ubuntu@<private-ip>   # hop into private EC2
```

The private EC2 is never directly reachable from the internet. The only path in is through the bastion, and your key never leaves your local machine.
