
---Identify segments that can be resized to reclaim space:

DECLARE
  job_name VARCHAR2(200);
BEGIN
  DBMS_SCHEDULER.create_job (
    job_name => 'SEGMENT_ADVISOR_JOB',
    job_type => 'PLSQL_BLOCK',
    job_action => 'BEGIN DBMS_SPACE.OBJECT_GROWTH_TREND (schema_name => ''YOUR_SCHEMA'', object_name => ''YOUR_OBJECT''); END;',
    start_date => SYSTIMESTAMP,
    enabled => TRUE
  );
END;
/
