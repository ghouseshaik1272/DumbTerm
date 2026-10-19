# GLinux deployment and GLab integration

## Recommended no-cost pilot host
Use an Oracle Cloud Infrastructure Always Free VM if your tenancy can provision one. For a Docker-based terminal, an Ubuntu 24.04 ARM64 VM with up to 2 OCPUs and 12 GB RAM is a reasonable pilot target within OCI's stated Always Free Ampere allowance. Capacity is not guaranteed, and signup/payment-card verification may be required. Confirm the instance shape is marked Always Free before creating it.

## 1. Create the VM and DNS record
1. Create an OCI account and choose the home region carefully; Always Free compute must be in the tenancy's home region.
2. Create an Ubuntu 24.04 ARM64 VM using the Always Free eligible Ampere A1 Flex shape. Start with 1 OCPU and 6 GB RAM if you want to leave room for other free resources; increase only within the eligible allowance.
3. Record its public IPv4 address.
4. In GoDaddy DNS, add an A record for `linux.devopsbyghouse.co.in` pointing to that public IPv4 address (or choose another subdomain you control).
5. In the OCI network security list or network security group, allow inbound TCP 80 and 443. Allow TCP 22 only from your trusted IP. Do not open port 3000.

## 2. Bootstrap and deploy
SSH into the new Ubuntu VM. After the DNS A record points to it, run:

```bash
git clone https://github.com/ghouseshaik1272/DumbTerm.git
cd DumbTerm
sudo bash deploy/bootstrap-ubuntu.sh
```

The script installs Docker and Compose, asks for the terminal domain, a private numeric PIN, and the trusted GLab website origin, then builds and starts GLinux behind Caddy with automatic HTTPS. If you use another hostname, enter that domain when prompted.

If you prefer manual setup, copy `.env.production.example` to `.env.production`, set a private PIN and the real domain, then run:

```bash
docker compose --env-file .env.production -f deploy/docker-compose.production.yml up -d --build
docker compose --env-file .env.production -f deploy/docker-compose.production.yml ps
docker compose --env-file .env.production -f deploy/docker-compose.production.yml logs -f
```

## 3. Connect the learning website
Set `GLINUX_URL=https://linux.devopsbyghouse.co.in` in the Next.js hosting provider's environment settings, then redeploy the learning site.

## Security notes
- This shared-PIN setup is only for a private pilot. A browser terminal executes commands, so do not invite public users until each learner has an isolated, resource-limited environment and proper identity-based authentication.
- Keep `.env.production` private. Do not mount the Docker socket, host root, SSH keys, cloud credentials, or sensitive host directories into the terminal.
- Review OCI's current Always Free limits and costs before provisioning. OCI may report insufficient host capacity for Always Free shapes; if so, retry later or use an eligible AWS credit/free plan as a temporary alternative.
