# GLinux deployment and GLab integration

## Local smoke test
1. Copy `.env.example` to `.env` and set a private numeric `DUMBTERM_PIN`.
2. Run `docker compose up -d --build`.
3. Check `docker compose ps` and `docker compose logs -f glinux`.
4. Open `http://localhost:3000` and verify login and terminal operation.
5. Run harmless commands: `pwd`, `whoami`, `cat /etc/os-release`, and `mkdir -p ~/test`.

## Before deployment
- Use a dedicated Docker host or sandboxing platform. Do not run learner commands directly on the GLab web host.
- Put the service behind HTTPS and suitable authentication.
- Set `BASE_URL` to the deployed HTTPS URL.
- Set `ALLOWED_ORIGINS` to exact trusted origins; avoid wildcard origins in production.
- Configure firewall rules, rate limits, container CPU/memory/PID limits, disk quotas, log rotation, and image updates.
- Do not mount `/var/run/docker.sock`, host root, SSH keys, cloud credentials, or other secrets.
- Treat PIN login as a basic gate, not per-user authorization.

## GLab website integration
Recommended initial approach: host GLinux on a dedicated subdomain and add a GLab navigation link. If embedding in an iframe, test authentication cookies, CSP/frame policy, and origin restrictions before enabling it.

## Multi-user roadmap
A shared shell is not a safe multi-user lab. Before onboarding external learners, provision a separate short-lived container per authenticated learner, with a non-root user, restricted capabilities, resource quotas, network policy, idle timeout, and automatic cleanup.

## Deployment status
GitHub stores the source; it does not run this container. The service is not public until deployed to a Docker-capable host and verified through its HTTPS URL.
