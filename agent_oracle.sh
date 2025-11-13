[oracle ~]$ cat start_agent.sh
/ora01/oracle/agent13c/agent_inst/bin/emctl start agent
[oracle@ ~]$ cat start_cloud13c.sh
srvctl start database -d cloud13c
[oracle@ ~]$ cat start_atldb.sh
srvctl start database -d atldb
[oracle@ ~]$ cat start_listener.sh
lsnrctl start
[oracle@ ~]$ cat start.sh
#!/bin/sh
 srvctl start database -d atldb

[oracle@ ~]$ cat status_agent.sh
/ora01/oracle/agent13c/agent_inst/bin/emctl status agent
[oracle@ ~]$ cat status_cloud13c.sh
srvctl status database -d cloud13c
[oracle@ ~]$ cat status_listener.sh
lsnrctl status
[oracle@ ~]$ cat status.sh
#!/bin/sh
 srvctl status database -d atldb

[oracle@ ~]$ cat
^C
[oracle@ ~]$ cat stop_listener.sh
lsnrctl stop

