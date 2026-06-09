# EC2 SSH Quickstart Guide
A step-by-step guide to launching an EC2 instance on AWS and connecting to it via SSH.

---

## Prerequisites
- An AWS account (free tier is sufficient)
- A terminal (Linux/macOS) or PuTTY (Windows)
- Your `.pem` key pair file from AWS

---

## Step 1: Launch an EC2 Instance

1. Go to the [AWS Console](https://console.aws.amazon.com) and navigate to **EC2**.
2. Click **Launch Instance**.
3. Fill in the following:
   - **Name:** give your instance a recognizable name (e.g., `my-first-ec2`)
   - **AMI:** select **Amazon Linux 2023** (free tier eligible)
   - **Instance type:** select **t2.micro** (free tier eligible)
4. Under **Key pair (login)**, click **Create new key pair**:
   - Give it a name (e.g., `my-ec2-key`)
   - Key pair type: **RSA**
   - Private key format: `.pem` (for terminal) or `.ppk` (for PuTTY on Windows)
   - Click **Create key pair** — the file will download automatically. **Keep this file safe. You cannot download it again.**
5. Under **Network settings**, ensure the following are checked:
   - Allow SSH traffic from: **My IP** (not 0.0.0.0/0 — never expose SSH to the entire internet)
6. Leave storage as default (8 GiB is fine for now).
7. Click **Launch Instance**.

---

## Step 2: Confirm the Instance is Running

1. Go to **EC2 > Instances**.
2. Wait until the **Instance State** shows **Running** and the **Status Check** column shows **2/2 checks passed**. This usually takes 1–2 minutes.
3. Click on your instance and note the **Public IPv4 address** — you will need this to connect.

---

## Step 3: Connect via SSH

### On Linux / macOS (Terminal)

1. Open your terminal and navigate to the folder where your `.pem` file is saved.

2. Fix the key file permissions — SSH will refuse to connect if the key is too permissive:
```bash
   chmod 400 my-ec2-key.pem
```
3. Connect using the following command:
```bash
   ssh -i my-ec2-key.pem ec2-user@<your-public-ip>
```
   Replace `<your-public-ip>` with the Public IPv4 address from Step 2.

4. When prompted with a fingerprint warning, type `yes` and press Enter.

5. You should now see the Amazon Linux welcome screen in your terminal — you are in.

---

### On Windows (PuTTY)

PuTTY does not accept `.pem` files directly. You first need to convert it to `.ppk` using **PuTTYgen**.

#### Convert .pem to .ppk using PuTTYgen

1. Download and open **PuTTYgen** (comes bundled with PuTTY).
2. Click **Load** and select your `.pem` file.
   - Make sure the file filter is set to **All Files (\*.\*)** — otherwise `.pem` files won't show up.
3. Click **Save private key** and save it as a `.ppk` file.
4. Close PuTTYgen.

#### Connect with PuTTY

1. Open **PuTTY**.
2. Under **Session > Host Name**, enter:

3. Under **Connection > SSH > Auth > Credentials**, click **Browse** and select your `.ppk` file.
4. Go back to **Session**, give it a name under **Saved Sessions**, and click **Save** so you don't have to repeat this setup.
5. Click **Open**.
6. When prompted with a security alert, click **Accept**.
7. You should now be connected to your EC2 instance.

#### Fix: PuTTY "Server refused our key" error

If PuTTY shows a **"Server refused our key"** error, the most common cause is that the `.ppk` was saved in PuTTYgen's newer format (version 3) which older PuTTY builds don't support. To fix:

1. Reopen PuTTYgen and load your `.ppk` file.
2. Go to **Key > Parameters for saving key files**.
3. Change the PPK file version to **2**.
4. Save the private key again, overwriting the old `.ppk`.
5. Retry the connection in PuTTY.

---

#### Fix: Windows Terminal — "Permissions are too open" error

If you are using Windows Terminal or PowerShell instead of PuTTY, the standard `chmod 400` command does not work on Windows. You will get an error like:Fix this using `icacls`:

```powershell
icacls "my-ec2-key.pem" /inheritance:r
icacls "my-ec2-key.pem" /grant:r "%USERNAME%:R"
```

Then retry the SSH command:
```powershell
ssh -i my-ec2-key.pem ec2-user@<your-public-ip>
```

---

## Step 4: Verify the Connection

Once connected, run a few commands to confirm everything is working:

```bash
# Check the OS
uname -a

# Check uptime
uptime

# Check your public IP (as seen from the instance)
curl ifconfig.me

# Check available disk space
df -h

# Check memory
free -h
```

If all of these return output, your instance is fully operational.

---

## Step 5: Disconnect and Stop the Instance

When you are done:

1. Type `exit` in the terminal to close the SSH session.
2. Go back to **EC2 > Instances** in the AWS Console.
3. Select your instance, click **Instance State > Stop**.
   - **Stop**, not **Terminate** — terminating deletes the instance permanently.
   - Stopping it means you are not billed for compute time while it is idle. Note that a stopped instance will get a new Public IP when restarted unless you assign an Elastic IP.

---

## Key Reminders

| Thing to remember | Why it matters |
|---|---|
| Never share your `.pem` or `.ppk` file | Anyone with it can access your instance |
| Always restrict SSH to your IP only | Exposing port 22 to 0.0.0.0/0 invites brute-force attacks |
| Stop instances when not in use | Free tier has an 750 hour/month limit across all running instances |
| Stopped instances get a new public IP | Use Elastic IP if you need a persistent address |
| Default username is `ec2-user` | This changes depending on the AMI — Ubuntu uses `ubuntu`, Debian uses `admin` |

---

## Default Usernames by AMI

| AMI | Default Username |
|---|---|
| Amazon Linux 2 / 2023 | `ec2-user` |
| Ubuntu | `ubuntu` |
| Debian | `admin` |
| CentOS | `centos` |
| RHEL | `ec2-user` or `root` |
| SUSE | `ec2-user` or `root` |
