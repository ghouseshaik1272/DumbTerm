# GLinux — by GLab

A browser-based Linux playground for learning Linux administration, command-line skills, and troubleshooting.

GLinux is the GLab-branded version of [DumbTerm](https://github.com/DumbWareio/DumbTerm), which provides the browser terminal and Docker foundation. The upstream GPL-3.0 license and attribution are retained.

> Status: Initial branding and learning-lab preparation. A successful GitHub commit does not mean the service is deployed.

## Features

- Real interactive shell inside a Docker container when DEMO_MODE is false.
- Browser terminal with multiple tabs, search, dark mode, and responsive layout.
- Debian-based container with common command-line utilities, Git, Python, editors, and networking tools.
- PIN-based login and persistent data/configuration volumes.
- Starter Linux exercises for files, permissions, processes, networking, and shell scripting.
- Docker Compose deployment.

## Quick start

Prerequisites: Docker Engine and the Docker Compose plugin.

1. Clone this repository.
2. Copy .env.example to .env.
3. Replace the placeholder DUMBTERM_PIN with a private numeric PIN.
4. Run the commands below from the repository directory.

    docker compose up -d --build
    docker compose logs -f

Open http://localhost:3000 and enter your PIN.

## Configuration

- SITE_TITLE: name shown in the browser; configured as GLinux.
- DUMBTERM_PIN: numeric login PIN; set a private value before sharing.
- BASE_URL: public base URL, including HTTPS and any path prefix if applicable.
- ALLOWED_ORIGINS: restrict browser origins to the actual GLab domain.
- DEMO_MODE: true means simulated terminal; false means real commands.
- MAX_SESSION_AGE: session lifetime in hours.
- LOCKOUT_TIME: PIN lockout duration in minutes.

Never commit a real PIN, tokens, or production secrets. Keep .env private.

## Learning path

See [docs/LINUX_LABS.md](docs/LINUX_LABS.md) for starter exercises and [docs/GLAB_DEPLOYMENT.md](docs/GLAB_DEPLOYMENT.md) for deployment and integration notes.

## Security before public access

A browser terminal executes commands inside its container. Do not expose it directly to the internet without HTTPS, authentication, origin restrictions, resource limits, and container isolation. Do not mount the Docker socket, host root, cloud credentials, or sensitive host directories into learner containers.

PIN protection is a basic gate, not a multi-user identity or isolation system. For a multi-user learning platform, provision a separate short-lived container per learner and apply CPU, memory, storage, network, and time limits. Test privately before connecting it to GLab.

## GLab integration

Host the terminal on a dedicated route or subdomain and link it from GLab. Configure BASE_URL, HTTPS, and ALLOWED_ORIGINS to match the actual deployment. GitHub stores source code; a Docker host or compatible deployment platform is required to run it.

## Upstream and license

Based on [DumbWareio/DumbTerm](https://github.com/DumbWareio/DumbTerm). The upstream LICENSE file is retained. Review and comply with GPL-3.0 obligations when distributing modified versions. Keep upstream attribution and project history available.

GLinux · A GLab learning project
