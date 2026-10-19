# Run GLinux locally (no cloud)

This setup runs GLinux on your own laptop using Docker. It does not create a cloud account, use a cloud VM, or publish the terminal to the internet.

## Start

1. Install and start Docker Desktop (Windows/macOS) or Docker Engine + Docker Compose v2 (Linux).
2. Clone the repository:

   ```bash
   git clone https://github.com/ghouseshaik1272/DumbTerm.git
   cd DumbTerm
   ```

3. On macOS/Linux, run:

   ```bash
   bash scripts/start-local-glinux.sh
   ```

   The script checks Docker, prompts for a private 6–12 digit PIN, creates a local-only `.env.local` file, builds the image and starts GLinux.

4. Open **http://localhost:3000** on the same laptop and enter the PIN you chose.

## Windows PowerShell alternative

From the cloned repository directory:

```powershell
$pin = Read-Host "Choose a private 6-12 digit numeric GLinux PIN"
if ($pin -notmatch '^\d{6,12}$') { throw "PIN must be 6-12 digits" }
@"
DUMBTERM_PIN=$pin
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
"@ | Set-Content -Encoding ascii .env.local
Remove-Variable pin
docker compose --env-file .env.local up -d --build
```

Then open **http://localhost:3000**.

## Useful commands

```bash
docker compose --env-file .env.local ps
docker compose --env-file .env.local logs -f
docker compose --env-file .env.local restart
docker compose --env-file .env.local down
```

- Keep `.env.local` private. Never commit it or share the PIN.
- Port 3000 is for local development. Do not port-forward it or expose it publicly.
- This is a single local terminal/container, not isolated per-user classroom infrastructure.
- When you stop Docker or shut down your laptop, the terminal will not be available. Other people cannot reach it through your GLab website in this local-only setup.
- First startup builds the image and needs an internet connection to download base images and dependencies; no cloud account or cloud VM is involved.
