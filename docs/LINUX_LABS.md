# GLinux Linux Practice Labs

Starter exercises for the GLab Linux Playground. Use a disposable learner container, not a production host.

## Lab 1 — Navigation
1. Run `pwd`, `whoami`, `uname -a`, and `cat /etc/os-release`.
2. Explore `ls -lah /` and `ls -lah ~`.
3. Explain absolute versus relative paths.

## Lab 2 — Files and directories
1. Create a workspace: `mkdir -p ~/glinux-labs/files`.
2. Create and inspect files using `touch`, `printf`, `cat`, `head`, and `tail`.
3. Copy, move, rename, and remove only test files using `cp`, `mv`, and `rm`.
4. Search text with `grep` and locate files with `find`.

## Lab 3 — Permissions
1. Create a shell script with a shebang and a simple `echo`.
2. Inspect permissions using `ls -l`; change them with `chmod`.
3. Compare `chmod 644 file`, `chmod 755 script.sh`, and `chmod u+x script.sh`.
4. Explain owner, group, and other permissions.

## Lab 4 — Processes and resources
1. Use `ps aux` and `top` (or `htop` if installed).
2. Inspect resources with `free -h`, `df -h`, and `du -sh ~/glinux-labs`.
3. Start `sleep 300`, stop it with Ctrl+C, and inspect process IDs.
4. Explain PID and parent PID.

## Lab 5 — Text processing
1. Practice `sort`, `uniq -c`, `wc -l`, `cut`, and `awk` on files you create.
2. Chain commands with pipes, such as `grep ERROR sample.log | wc -l`.
3. Compare output redirection with `>` and `>>`.

## Lab 6 — Networking
1. Inspect interfaces and routes with `ip addr` and `ip route` if available.
2. Test name resolution with `getent hosts example.com` if networking is enabled.
3. Inspect HTTP headers using `curl -I https://example.com` if outbound access is allowed.
4. Explain DNS, IP address, port, TCP, and HTTP.

## Lab 7 — Archives
1. Create and list an archive using `tar -czf` and `tar -tzf`.
2. Extract it into a temporary directory.
3. Check for apt with `command -v apt`. Do not install packages unless explicitly allowed.

## Lab 8 — Bash scripting
1. Write a script that prints the date, current user, and working directory.
2. Add variables, arguments, an `if` statement, and a `for` loop.
3. Use `set -eu` and explain why variables should be quoted.
4. Check syntax with `bash -n script.sh`.

## Lab 9 — Troubleshooting
1. Permission denied: inspect path and permissions before changing anything.
2. Missing file: verify `pwd`, list hidden files, and search your workspace.
3. Script fails: run `bash -n`, inspect the shebang, and check line endings.
4. Disk usage: compare `df -h` with `du -sh` for your workspace.
5. DNS failure: distinguish name-resolution problems from general connectivity.

## Completion checklist
- [ ] Navigate and manage files safely
- [ ] Explain permissions and executable bits
- [ ] Inspect processes and resources
- [ ] Use pipelines and redirection
- [ ] Inspect basic networking
- [ ] Create and debug Bash scripts
- [ ] Troubleshoot methodically

**Safety:** each lab should run in an isolated learner container. Never mount host secrets into the terminal.
