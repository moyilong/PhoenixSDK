@echo off
set downloads=%1\Downloads
set log=%1\log.txt
if not exist %downloads% mkdir %downloads% && echo >%downloads%\aria2.list
start aria2c.exe  --enable-rpc=true --rpc-listen-all=true --rpc-allow-origin-all=true --log-level=notice --log="%log%" --dir="%downloads%" --disk-cache=10M --min-split-size=20M --file-allocation=trunc --max-connection-per-server=10 --max-tries=0  --retry-wait=20 --save-session=%downloads%\aria2.list --input-file=%downloads%\aria2.list --force-save=true 
pause>nul