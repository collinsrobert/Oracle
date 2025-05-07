sh /home/oracle/standby/check_standby.sh
exit
#############
#!/bin/bash
PARALLELISM=4
PERL5LIB=$ORACLE_HOME/rdbms/admin:$PERL5LIB; export PERL5LIB
export ORACLE_HOME=/ora01/app/oracle/19c
export ORACLE_SID=insightdb
export PATH=$ORACLE_HOME/bin:$PATH

sqlplus "/ as sysdba" @check_standby.sql

################################



#############################################################################

######################################################cat /home/oracle/standby/check_standby.sql
declare
v_cnt number;
v_db varchar2(50);
v_log1 varchar2(50);
v_log2 varchar2(50);
v_logdir varchar2(500);
begin
SELECT DB_NAME,
--HOSTNAME,
LOG_ARCHIVED,
NVL(LOG_APPLIED,0) as LOG_APPLIED,
--APPLIED_TIME,
LOG_ARCHIVED-NVL(LOG_APPLIED,0) LOG_GAP
into v_db, v_log1, v_log2, v_cnt
FROM
(
SELECT NAME DB_NAME
FROM V$DATABASE
),
(
SELECT UPPER(SUBSTR(HOST_NAME,1,(DECODE(INSTR(HOST_NAME,'.'),0,LENGTH(HOST_NAME),
(INSTR(HOST_NAME,'.')-1))))) HOSTNAME
FROM V$INSTANCE
),
(
SELECT MAX(SEQUENCE#) LOG_ARCHIVED
FROM V$ARCHIVED_LOG WHERE DEST_ID=1 AND ARCHIVED='YES'
),
(
SELECT MAX(SEQUENCE#) LOG_APPLIED
FROM V$ARCHIVED_LOG WHERE DEST_ID=2 AND APPLIED='YES'
),
(
SELECT TO_CHAR(MAX(COMPLETION_TIME),'DD-MON/HH24:MI') APPLIED_TIME
FROM V$ARCHIVED_LOG WHERE DEST_ID=2 AND APPLIED='YES'
);

IF v_cnt > 60
  then
  select destination
  into v_logdir
  from v$archive_dest
  where dest_name = 'LOG_ARCHIVE_DEST_2';
  notify.pkg_notify.send_email(psender => 'cloud_control_dataservices@ingram.com',
            precipients => 'dataservices@ingrambarge.com',
               psubject => 'CRITICAL - DB = '||v_db||' Has ArchiveLog Gap!',
               pmessage => 'Check '||v_db||' For ArchiveLog Gaps.
  This may mean that recovery is not in process.
  Last Log on Primary = '||v_log1||'.
  Last Log on Standby = '||v_log2||'.
  Verify that the MISSING Logfiles exist on standby site.
  To verify that logfiles exist, login to standby host with your _ADMIN id, or as the OracleDBA_User.  The Standby server
  will be spvazuora21.
  Once you have logged in, verify that the archivelogs are the same in the '||v_logdir||' for the primary and standby dbs.
  If there are missing logfiles (there should not be), you will need to contact Data Services because the restoration of
    missing archivelogs is complex.

  Issue the following command:
  alter database recover managed standby database disconnect from session;
  The database should now begin recovering.  If error notifications are still received please contact Data Services.'
            );
end if;
end;
/


####################################################################################
