DECLARE
  l_sql_id VARCHAR2(13);
  l_report CLOB;
BEGIN
  l_sql_id := DBMS_SQLTUNE.SQLTEXT_TO_SQLID('SELECT * FROM dual');
  l_report := DBMS_SQLTUNE.REPORT_SQL_MONITOR(sql_id => l_sql_id, type => 'TEXT');
  DBMS_OUTPUT.PUT_LINE(l_report);
END;
/
---Database Health Check
---Use DBMS_SQLTUNE to perform a database health check:
