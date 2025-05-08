[oracle@myservername bin]$ pwd
/u02/app/middleware/oms_home/bin
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$ ./emcli version
Oracle Enterprise Manager 24ai EM CLI Version 24.1.0.0.0
[oracle@myservername bin]$ mkdir -p /u02/app/oem_swlib
[oracle@myservername bin]$ ./emcli get_agentimage -destination=/u02/app/oem_swlib -platform="Linux x86-64" -version="^C.1.0.0.0"
[oracle@myservername bin]$ mkdir -p /u02/app/oem_swlib
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$
[oracle@myservername bin]$  ./emcli get_agentimage -destination=/u02/app/oem_swlib -platform="Linux x86-64" -version="24.1.0.0.0"
 === Partition Detail ===
Space free : 37 GB
Space required : 1 GB
Check the logs at /u02/app/middleware/gc_inst/em/EMGC_OMS1/sysman/emcli/setup/.emcli/get_agentimage_2025-05-08_16-56-42-PM.log
Error :Error: Session expired. Run emcli login to establish a session.

[oracle@myservername bin]$ tail /u02/app/middleware/gc_inst/em/EMGC_OMS1/sysman/emcli/setup/.emcli/get_agentimage_2025-05-08_16-56-42-PM.log
Destination:/u02/app/oem_swlib
Platform:Linux x86-64
Free Space available:37
[oracle@myservername bin]$ mkdir -p /u02/app/oem_swlib
[oracle@myservername bin]$ emcli login -username=sysman
-bash: emcli: command not found
[oracle@myservername bin]$ ./emcli login -username=sysman
Enter password :

Login successful



[oracle@myservername bin]$  ./emcli get_agentimage -destination=/u02/app/oem_swlib -platform="Linux x86-64" -version="24.1.0.0.0"
 === Partition Detail ===
Space free : 37 GB
Space required : 1 GB
Check the logs at /u02/app/middleware/gc_inst/em/EMGC_OMS1/sysman/emcli/setup/.emcli/get_agentimage_2025-05-08_16-58-26-PM.log
Downloading /u02/app/oem_swlib/24.1.0.0.0_AgentCore_226.zip
File saved as /u02/app/oem_swlib/24.1.0.0.0_AgentCore_226.zip
Downloading /u02/app/oem_swlib/24.1.0.0.0_Plugins_226.zip
File saved as /u02/app/oem_swlib/24.1.0.0.0_Plugins_226.zip
Downloading /u02/app/oem_swlib/unzip
File saved as /u02/app/oem_swlib/unzip
Executing command: /u02/app/oem_swlib/unzip /u02/app/oem_swlib/24.1.0.0.0_Plugins_226.zip -d /u02/app/oem_swlib
Archieving agentImage and plugins.
Exit status is:0
Agent Image Download completed successfully.
[oracle@myservername bin]$ cd  /u02/app/oem_swlib/
[oracle@myservername oem_swlib]$ ll
total 650264
-rw-r--r--. 1 oracle oinstall 665864178 May  8 16:58 24.1.0.0.0_AgentCore_226.zip
