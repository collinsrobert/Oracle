--cat adump_purge.sql
begin

dbms_output.put_line(‘Checking if cleanup is initialized.’);
if
dbms_audit_mgmt.is_cleanup_initialized(dbms_audit_mgmt.audit_trail_aud_std)
then
dbms_output.put_line(‘Audit Management is initialized for clean-up’);
else
dbms_output.put_line(‘Audit Management is not initialized for clean-up. Doing it now.’);
sys.dbms_audit_mgmt.init_cleanup(audit_trail_type => sys.dbms_audit_mgmt.audit_trail_all,default_cleanup_interval => 72 );
----NOTE: The 72 is meaningless here. MOS Note 1243324.1
end if;

dbms_output.put_line(‘Setting archive timestamps. Older data will be purged.’);
dbms_output.put_line(‘…OS Files: ${vAuditMGMTDaysOS}’);
dbms_output.put_line(‘…DB: ${vnAuditRetention}’);

sys.dbms_audit_mgmt.set_last_archive_timestamp(
audit_trail_type => sys.dbms_audit_mgmt.audit_trail_aud_std,
last_archive_time => systimestamp – ${vnAuditRetention});

sys.dbms_audit_mgmt.set_last_archive_timestamp(
audit_trail_type => sys.dbms_audit_mgmt.audit_trail_os,
last_archive_time => sysdate – ${vAuditMGMTDaysOS});

dbms_output.put_line(‘Purging audit records’);

dbms_audit_mgmt.clean_audit_trail(
audit_trail_type => dbms_audit_mgmt.audit_trail_os,
use_last_arch_timestamp => TRUE );

dbms_audit_mgmt.clean_audit_trail(
audit_trail_type => dbms_audit_mgmt.audit_trail_aud_std,
use_last_arch_timestamp => TRUE );

dbms_output.put_line(‘Current archive stats’);
end;
/
set lines 999
col audit_trail for a35;
col last_archive_ts for a50;
select audit_trail, last_archive_ts, rac_instance from DBA_AUDIT_MGMT_LAST_ARCH_TS;

exit;
