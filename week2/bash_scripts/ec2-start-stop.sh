#!/bin/bash
###############################################
# ec2-start-stop.sh
# Description : Start or stop an EC2 instance
# Usage       : ./ec2-start-stop.sh <start|stop> <instance-id>
# Example     : ./ec2-start-stop.sh start i-0abc123def456789
# Requires    : aws cli, jq
###############################################

ACTION="$1"
INSTANCE_ID="$2"
REGION="ap-southeast-1"   # change to your region

# ── Input validation ──────────────────────────
if [[ -z "$ACTION" || -z "$INSTANCE_ID" ]]; then
  echo "Usage: $0 <start|stop> <instance-id>"
  exit 1
fi

if [[ "$ACTION" != "start" && "$ACTION" != "stop" ]]; then
  echo "[ERROR] Action must be 'start' or 'stop'."
  exit 1
fi

# ── Check current state ───────────────────────
echo "[INFO] Checking current state of $INSTANCE_ID..."

CURRENT_STATE=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION" \
  --query "Reservations[0].Instances[0].State.Name" \
  --output text)

echo "[INFO] Current state: $CURRENT_STATE"

# ── Guard: skip if already in target state ────
if [[ "$ACTION" == "start" && "$CURRENT_STATE" == "running" ]]; then
  echo "[SKIP] Instance is already running."
  exit 0
fi

if [[ "$ACTION" == "stop" && "$CURRENT_STATE" == "stopped" ]]; then
  echo "[SKIP] Instance is already stopped."
  exit 0
fi

# ── Execute action ────────────────────────────
if [[ "$ACTION" == "start" ]]; then
  echo "[INFO] Starting instance $INSTANCE_ID..."
  aws ec2 start-instances \
    --instance-ids "$INSTANCE_ID" \
    --region "$REGION"

  echo "[INFO] Waiting for instance to reach 'running' state..."
  aws ec2 wait instance-running \
    --instance-ids "$INSTANCE_ID" \
    --region "$REGION"

  PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --region "$REGION" \
    --query "Reservations[0].Instances[0].PublicIpAddress" \
    --output text)

  echo "[OK] Instance is running. Public IP: $PUBLIC_IP"

else
  echo "[INFO] Stopping instance $INSTANCE_ID..."
  aws ec2 stop-instances \
    --instance-ids "$INSTANCE_ID" \
    --region "$REGION"

  echo "[INFO] Waiting for instance to reach 'stopped' state..."
  aws ec2 wait instance-stopped \
    --instance-ids "$INSTANCE_ID" \
    --region "$REGION"

  echo "[OK] Instance is stopped."
fi