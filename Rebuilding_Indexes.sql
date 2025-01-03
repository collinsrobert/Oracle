
---Rebuilding Indexes
--Rebuilding indexes can help improve performance by reducing fragmentation:

BEGIN
  FOR r IN (SELECT index_name, table_owner, table_name
            FROM dba_indexes
            WHERE status = 'VALID' AND owner = 'YOUR_SCHEMA') LOOP
    EXECUTE IMMEDIATE 'ALTER INDEX ' || r.table_owner || '.' || r.index_name || ' REBUILD';
  END LOOP;
END;
/
