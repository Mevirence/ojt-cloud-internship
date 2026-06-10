# Linux Cheat Sheet

## Navigation

| Command | Description |
|----------|-------------|
| `pwd` | Show current directory |
| `ls` | List files and directories |
| `ls -la` | List all files with details |
| `cd folder` | Enter a directory |
| `cd ..` | Go up one directory |
| `cd ~` | Go to home directory |
| `tree` | Display directory structure |

---

## File Operations

| Command | Description |
|----------|-------------|
| `touch file.txt` | Create empty file |
| `cat file.txt` | Display file contents |
| `nano file.txt` | Edit file using Nano |
| `vim file.txt` | Edit file using Vim |
| `cp file1 file2` | Copy file |
| `mv file1 file2` | Move or rename file |
| `rm file.txt` | Delete file |
| `rm -r folder` | Delete directory recursively |
| `mkdir folder` | Create directory |
| `rmdir folder` | Remove empty directory |

---

## File Permissions

### View Permissions

```bash
ls -l
```

Example:

```bash
-rwxr-xr-- 1 user user 1234 file.sh
```

### Change Permissions

```bash
chmod 755 file.sh
chmod +x file.sh
```

### Change Ownership

```bash
sudo chown user:user file.sh
```

---

## User Management

| Command | Description |
|----------|-------------|
| `whoami` | Current user |
| `id` | User information |
| `users` | Logged-in users |
| `sudo command` | Run command as administrator |
| `passwd` | Change password |

---

## Process Management

| Command | Description |
|----------|-------------|
| `ps` | Running processes |
| `ps aux` | Detailed process list |
| `top` | Real-time process monitor |
| `htop` | Enhanced process monitor |
| `kill PID` | Terminate process |
| `kill -9 PID` | Force terminate process |
| `jobs` | Background jobs |
| `bg` | Resume job in background |
| `fg` | Bring job to foreground |

---

## System Information

| Command | Description |
|----------|-------------|
| `uname -a` | System information |
| `hostname` | Machine hostname |
| `uptime` | System uptime |
| `date` | Current date and time |
| `free -h` | Memory usage |
| `df -h` | Disk usage |
| `du -sh folder` | Folder size |
| `lscpu` | CPU information |
| `ip addr` | Network interfaces |

---

## Package Management

### Ubuntu / Debian

```bash
sudo apt update
sudo apt upgrade
sudo apt install package-name
sudo apt remove package-name
```

### CentOS / RHEL

```bash
sudo yum update
sudo yum install package-name
```

### Fedora

```bash
sudo dnf install package-name
```

---

## Searching

### Find Files

```bash
find /path -name "file.txt"
```

### Search Text

```bash
grep "keyword" file.txt
grep -r "keyword" .
```

### Locate Files

```bash
locate filename
```

---

## Networking

### Check IP Address

```bash
ip addr
```

### Test Connectivity

```bash
ping google.com
```

### DNS Lookup

```bash
nslookup google.com
```

### Download Files

```bash
wget URL
curl -O URL
```

### Open Ports

```bash
ss -tuln
```

---

## SSH

### Connect to Remote Server

```bash
ssh username@server-ip
```

### Connect Using Key Pair

```bash
ssh -i key.pem username@server-ip
```

### Copy File to Server

```bash
scp file.txt username@server-ip:/home/user/
```

### Copy File from Server

```bash
scp username@server-ip:/home/user/file.txt .
```

---

## Compression

### Create ZIP

```bash
zip archive.zip file.txt
```

### Extract ZIP

```bash
unzip archive.zip
```

### Create TAR

```bash
tar -cvf archive.tar folder/
```

### Compress TAR

```bash
tar -czvf archive.tar.gz folder/
```

### Extract TAR.GZ

```bash
tar -xzvf archive.tar.gz
```

---

## Logs

### View Entire Log

```bash
cat logfile.log
```

### View End of Log

```bash
tail logfile.log
```

### Live Log Monitoring

```bash
tail -f logfile.log
```

### View Beginning of Log

```bash
head logfile.log
```

---

## Services (systemd)

### Check Service Status

```bash
systemctl status nginx
```

### Start Service

```bash
sudo systemctl start nginx
```

### Stop Service

```bash
sudo systemctl stop nginx
```

### Restart Service

```bash
sudo systemctl restart nginx
```

### Enable on Boot

```bash
sudo systemctl enable nginx
```

---

## Useful Shortcuts

| Shortcut | Description |
|-----------|------------|
| `Ctrl + C` | Stop current process |
| `Ctrl + Z` | Suspend process |
| `Ctrl + D` | Logout / End input |
| `Ctrl + L` | Clear screen |
| `Tab` | Auto-complete |
| `↑` | Previous command |
| `history` | Command history |

---

## Disk & Storage

### Show Mounted Drives

```bash
mount
```

### List Block Devices

```bash
lsblk
```

### Disk Usage

```bash
df -h
```

### Folder Size

```bash
du -sh *
```

---

## Environment Variables

### View Variables

```bash
printenv
```

### Display Specific Variable

```bash
echo $PATH
```

### Set Variable Temporarily

```bash
export MY_VAR="hello"
```

---

## Useful OJT / Cloud Commands

### Check Public IP

```bash
curl ifconfig.me
```

### Check Running Services

```bash
systemctl --type=service
```

### Monitor Server Resources

```bash
top
```

### Follow System Logs

```bash
journalctl -f
```

### Check SSH Service

```bash
systemctl status ssh
```

### Check Open Ports

```bash
ss -tulnp
```

---

## Golden Rule

Before running a command you don't fully understand:

```bash
man command
```

Example:

```bash
man ssh
man chmod
man systemctl
```

Or use:

```bash
command --help
```

Example:

```bash
ssh --help
chmod --help
```
