#!/bin/bash




  # Set oracle database name in the environment
  export ORACLE_SID="LIUSIGHTDB" ####Enter Oracle SID name
  export ORACLE_HOME="/ora01/oracle/production/19c_home"     #########Enetr oracle home
  . oraenv <<< "$ORACLE_SID"
  
  
  # Remove old log file
rm -f /home/oracle/fetch_details_$ORACLE_SID.log

# Log file path
log_file="/home/oracle/fetch_details_$ORACLE_SID.log"


# Database patch info 

  echo " Collecting database home info"  | tee -a "$log_file"
  
  $ORACLE_HOME/OPatch/opatch lsinv |grep ^Patch  | tee -a "$log_file"


  # Validate values set above
  echo "Environment variables set for ORACLE_SID=$ORACLE_SID, ORACLE_HOME=$ORACLE_HOME:" | tee -a "$log_file"
  env | grep ORA | tee -a "$log_file"

  # Connect to SQL*Plus and execute queries
  sqlplus -S / as sysdba <<EOF | grep -v 'PL/SQL procedure successfully completed' | tee -a "$log_file"

  set serveroutput on;
  exec dbms_output.put_line('Database Information');
  set pagesize 300
  set linesize 300
  col FORCE_LOGGING for a16
  select NAME,LOG_MODE,OPEN_MODE,PROTECTION_MODE,DATABASE_ROLE,FORCE_LOGGING,FLASHBACK_ON,DB_UNIQUE_NAME from v\$database;

  exec dbms_output.put_line('Redo Log File Information');
  set linesize 300
  set pagesize 300
  col MEMBER for a75
  select v.group#,thread#,bytes/1024/1024,l.type,l.member,v.status from v\$log v ,v\$logfile l where v.group#=l.group#;

  exec dbms_output.put_line('Standby Redo Log File Information');
  set linesize 300
  set pagesize 300
  col MEMBER for a75
  select v.group#,thread#,bytes/1024/1024,l.type,l.member,v.status from v\$standby_log v ,v\$logfile l where v.group#=l.group#;

  exec dbms_output.put_line('Encryption Wallet details ');
  set linesize 300
  set pagesize 300
  col wrl_type for a20
  col status for a20
  col wrl_parameter for a100
  select wrl_type wallet,status,wrl_parameter wallet_location from v\$encryption_wallet;

  exec dbms_output.put_line('Remote login password detail ');
  show parameter REMOTE_LOGIN_PASSWORDFILE;

  exec dbms_output.put_line('Datafile Name ');
  set linesize 300
  set pagesize 300
  col name for a100
  select name from v\$datafile;

  exec dbms_output.put_line('Datafile Count');
  select count(*) from v\$datafile;

  exec dbms_output.put_line('Archive log detail');
  archive log list;

  exec dbms_output.put_line('Oracle binary details');
  set linesize 300
  set pagesize 300
  col comp_id for a15
  col status for a10
  col version for a15
  col comp_name for a40
  SELECT SUBSTR(comp_id,1,15) comp_id, status, SUBSTR(version,1,10) version, SUBSTR(comp_name,1,40) comp_name FROM dba_registry;
  
 exec dbms_output.put_line('Character Set details');
 set linesize 1000
 col property_name for a30
 col property_value for a20
 col description for a40
 SELECT property_name, property_value, description FROM database_properties WHERE property_name IN ('NLS_CHARACTERSET', 'NLS_NCHAR_CHARACTERSET') ORDER BY 1;

  exec dbms_output.put_line('Database size');
  exec dbms_output.put_line('Database Size using dba-segments');
  select sum(bytes)/1024/1024/1024 size_in_gb from dba_segments;

  exec dbms_output.put_line(' Database Size using dba-data-files');
  select sum(bytes)/1024/1024/1024 size_in_gb from dba_data_files;
  
  exec dbms_output.put_line(' table space infomration ');
  select * from v\$tablespace;

  exec dbms_output.put_line('Time Zone version');
  set linesize 300
  set pagesize 300
  col PROPERTY_NAME for a60
  col VALUE for a30
  SELECT PROPERTY_NAME, SUBSTR(property_value, 1, 30) value
  FROM DATABASE_PROPERTIES
  WHERE PROPERTY_NAME LIKE 'DST_%'
  ORDER BY PROPERTY_NAME;

EOF



# Fetch OS-level details and append to the log file
echo -e "\nOS-level details:" | tee -a "$log_file"
echo -e "\nDisk Usage:\n$(df -kh)" | tee -a "$log_file"
echo -e "\nFree Memory:\n$(free -g)" | tee -a "$log_file"
echo -e "\nCPU Information:\n$( lscpu)" | tee -a "$log_file"

# Create pfile.log from spfile
echo -e "\nCreating pfile.log from spfile:" | tee -a "$log_file"
sqlplus -S / as sysdba <<EOF | tee -a "$log_file"
create pfile='$ORACLE_HOME/dbs/pfile.log' from spfile;
exit;
EOF

# Append pfile.log content to the log file
echo -e "\nContents of pfile.log:" | tee -a "$log_file"
cat "$ORACLE_HOME/dbs/pfile.log" | tee -a "$log_file"

echo -e "\nOracle Configuration Files:" | tee -a "$log_file"
echo -e "\nsqlnet.ora:\n$(cat $ORACLE_HOME/network/admin/sqlnet.ora)" | tee -a "$log_file"
echo -e "\nlistener.ora:\n$(cat $ORACLE_HOME/network/admin/listener.ora)" | tee -a "$log_file"
echo -e "\ntnsnames.ora:\n$(cat $ORACLE_HOME/network/admin/tnsnames.ora)" | tee -a "$log_file"

echo -e "\nScript execution completed." | tee -a "$log_file"
