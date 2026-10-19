#!/usr/bin/env bash
set -Eeuo pipefail

# GLinux bootstrap for a fresh Ubuntu 24.04 VM.
# Run as root after the DNS A record points at this VM and ports 80/443 are allowed.
if [[ "${EUID}" -ne 0 ]]; then
  echo "Run with sudo: sudo bash deploy/bootstrap-ubuntu.sh"
  exit 1
fi

DOMAIN="${GLINUX_DOMAIN:-linux.devopsbyghouse.co.in}"
read -r -p "GLinux domain [${DOMAIN}]: " input_domain
DOMAIN="${input_domain:-$DOMAIN}"
if [[ ! "$DOMAIN" =~ ^[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
  echo "That does not look like a valid hostname."
  exit 1
fi

echo "Enter a private numeric PIN of 6-12 digits. Do not reuse an important password."
while true; do
  read -r -s -p "GLinux PIN: " PIN
  echo
  if [[ "$PIN" =~ ^[0-9]{6,12}$ ]]; then break; fi
  echo "PIN must contain 6-12 digits."
done

read -r -p "Allowed GLab origin [https://learn.devopsbyghouse.co.in]: " ORIGIN
ORIGIN="${ORIGIN:-https://learn.devopsbyghouse.co.in}"
if [[ ! "$ORIGIN" =~ ^https:// ]]; then
  echo "Use the full HTTPS origin, for example https://learn.devopsbyghouse.co.in"
  exit 1
fi

if ! getent ahosts "$DOMAIN" >/dev/null; then
  echo "WARNING: DNS for $DOMAIN does not resolve yet. Configure its A record to this VM public IP before TLS can succeed."
fi

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git docker.io docker-compose-v2
systemctl enable --now docker

INSTALL_DIR="/opt/glinux"
if [[ -d "$INSTALL_DIR/.git" ]]; then
  git -C "$INSTALL_DIR" pull --ff-only
elif [[ -e "$INSTALL_DIR" ]]; then
  echo "$INSTALL_DIR exists but is not a Git checkout. Move it aside and rerun."
  exit 1
else
  git clone --depth 1 https://github.com/ghouseshaik1272/DumbTerm.git "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"
umask 077
cat > .env.production <<EOF
GLINUX_DOMAIN=$DOMAIN
DUMBTERM_PIN=$PIN
ALLOWED_ORIGINS=$ORIGIN
DUMBTERM_TZ=Asia/Kolkata
DUMBTERM_LOCKOUT_TIME=15
DUMBTERM_MAX_SESSION_AGE=24
ENABLE_STARSHIP=true
EOF
unset PIN

docker compose --env-file .env.production -f deploy/docker-compose.production.yml up -d --build
echo
echo "GLinux deployment command finished."
echo "URL: https://$DOMAIN"
echo "Check status: cd $INSTALL_DIR && docker compose --env-file .env.production -f deploy/docker-compose.production.yml ps"
echo "Logs:         cd $INSTALL_DIR && docker compose --env-file .env.production -f deploy/docker-compose.production.yml logs -f"
echo "Ensure the cloud firewall allows TCP 80/443 and restricts SSH (TCP 22) to your IP."
