#!/usr/bin/env bash
set -Eeuo pipefail

# Local-only GLinux launcher. No cloud resources or public ports are required.
# Run from any directory; this script locates the repository root.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker was not found. Install/start Docker Desktop or Docker Engine, then retry."
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  echo "Docker is installed but the Docker daemon is not running or this user lacks access."
  echo "Start Docker Desktop / Docker Engine and retry."
  exit 1
fi
if ! docker compose version >/dev/null 2>&1; then
  echo "Docker Compose v2 is required. Install the Docker Compose plugin and retry."
  exit 1
fi

ENV_FILE="$ROOT_DIR/.env.local"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Create a private local PIN (6-12 digits). Do not reuse an important password."
  while true; do
    read -r -s -p "Local GLinux PIN: " PIN
    echo
    if [[ "$PIN" =~ ^[0-9]{6,12}$ ]]; then break; fi
    echo "PIN must contain 6-12 digits."
  done
  umask 077
  cat > "$ENV_FILE" <<EOF
DUMBTERM_PIN=$PIN
DUMBTERM_PORT=3000
DUMBTERM_SITE_TITLE=GLinux
DUMBTERM_BASE_URL=http://localhost:3000
DUMBTERM_ALLOWED_ORIGINS=http://localhost:3000
DUMBTERM_TZ=Asia/Kolkata
DUMBTERM_CONFIG=./config
DUMBTERM_DATA_DIR=./data
DUMBTERM_LOCKOUT_TIME=15
DUMBTERM_MAX_SESSION_AGE=24
ENABLE_STARSHIP=true
EOF
  unset PIN
  echo "Created $ENV_FILE (kept local; do not commit it)."
fi

docker compose --env-file "$ENV_FILE" up -d --build
echo
echo "GLinux is starting locally: http://localhost:3000"
echo "Check status: docker compose --env-file .env.local ps"
echo "View logs:    docker compose --env-file .env.local logs -f"
echo "Stop it:      docker compose --env-file .env.local down"
