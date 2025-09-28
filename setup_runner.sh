#!/bin/bash
set -e

# === Variables ===
REPO_URL="https://github.com/shanmugam-beeonlink/sample"
RUNNER_VERSION="2.321.0"
RUNNER_DIR="$HOME/actions-runner"

# === Install dependencies ===
sudo apt update -y
sudo apt install -y curl tar docker.io

# === Create runner folder ===
mkdir -p $RUNNER_DIR
cd $RUNNER_DIR

# === Download GitHub Actions runner ===
echo "Downloading GitHub Actions runner v$RUNNER_VERSION..."
curl -o actions-runner-linux-x64-$RUNNER_VERSION.tar.gz -L \
  https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

# === Extract package ===
tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

# === Configure runner ===
echo ""
echo "👉 Go to: $REPO_URL"
echo "   Settings → Actions → Runners → New self-hosted runner → Linux → x64"
echo "   Copy the config.sh command with token and paste below."
echo ""
read -p "Paste your config.sh command here: " CONFIG_CMD

eval $CONFIG_CMD

# === Install & start runner as service ===
sudo ./svc.sh install
sudo ./svc.sh start

echo ""
echo "✅ Self-hosted runner is installed and running as service!"
