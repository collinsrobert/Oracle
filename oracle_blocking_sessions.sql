select to_char(sysdate,'DD-MON-YYYY:HH24:MI') as DT,t1.sid as BlockedSession,t1.serial#
,t1.sql_id as BlockedSQLID
,t1.prev_sql_id as BlockedPSQLID
,t1.module
,t1.username as BlockedUser
,t1.status as BlockedStatus
,t1.blocking_session as BlockingSession
,t1.seconds_in_wait as WaitingSeconds
,t1.event
,t1.wait_class
,t2.sid as BlockingSession,t2.serial# as BlockingSerial
,t2.sql_id as BlockingSQLID
,t2.prev_sql_id as BlockingPSQLID
,t2.username as BlockingUser
,t2.status as BlockingStatus
,t3.sql_text as BlockedSQL
,t4.sql_text as BlockingSQL
from  gv$session t1
left join gv$session t2 on (t1.blocking_session=t2.sid )
left join v$sqlarea t3 on (t1.sql_id=t3.sql_id or t1.prev_sql_id=t3.sql_id)
left join v$sqlarea t4 on (t2.sql_id=t4.sql_id or t2.prev_sql_id=t4.sql_id)
where t1.blocking_session is not null
and t1.seconds_in_wait > 60;
