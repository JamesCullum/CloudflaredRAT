# Cloudflared RAT

[![Icon](https://raw.githubusercontent.com/JamesCullum/CloudflaredRAT/master/.github/images/gopher.png)](https://gopherize.me/)

CloudflaredRAT is a simple combination of popular open-source tools, wrapping a local-facing shell with Cloudflares Argo Tunnel in an executable, to create a persistent internet-facing encrypted web shell for remote access. It is designed and created for red teams, as it does not scale well. Make sure you have permission of the target (company) before using it.

| Advantages   | Disadvantages |
|----------|-------------|
| Gets around the firewall |  Can easily be analyzed and removed, once found |
| Combination of standard resources evade AntiVirus and EDR systems | Not anonymous to Cloudflare |
| No server required = no OPSEC risk | Attack does not scale for many targets, as each target needs their own tunnel |
| Web shell accessible via protected domain ||

## Shell2HTTP
- [shell2http](https://github.com/msoap/shell2http) run as local-facing web shell
- Allows file upload, file execution and full terminal access
- Mandates authentication

## Cloudflare Argo Tunnel
- [Argo tunnels](https://developers.cloudflare.com/argo-tunnel/) allow a device to be accessible from the internet using Cloudflare services
  - Cloudflare offers services such as whois-protected domains, protecting origin servers and custom access rules. Its is a great tool for red teams.
- Tunnels use an encrypted HTTPS tunnel to the Cloudflare network, which makes traffic almost invisible
- Cloudflare [recently introduced](https://blog.cloudflare.com/argo-tunnels-that-live-forever/) Argo tunnels which have limited access permission and restore themselves on a restart. This allows to use tunnels to make target computers visible on the internet consistently.

## Wrapper
- Uses [WinRAR](https://www.win-rar.com/) to create a self-extracting archive executable with custom icon
- Helper powershell scripts (1_configure.ps1 & 2_build.ps1) to configure and build the RAT
- Scheduled Tasks used for persistence
- Runs shell as SYSTEM user by default

# Get started

1. Download and extract the repository
2. Make sure you have WinRAR installed and the WinRAR.exe configured in your PATH
3. File `bridge.exe` contains the cloudflared CLI. Use it to [create a JSON file for the target tunnel](https://blog.cloudflare.com/argo-tunnels-that-live-forever/#how-it-works). 
4. [Map the argo tunnel hostname to a public facing domain](https://developers.cloudflare.com/argo-tunnel/routing-to-tunnel/dns) on Cloudflare.
5. Run `1_configure.ps1` and fill in the variables when prompted
6. (Optional) Replace the icon.ico with the icon you want to use instead for your executable
7. Run `2_build.ps1` to create the executable
8. Execute on the target machine and wait for thr website to be available
