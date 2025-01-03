--Purging Recycle Bin
--The recycle bin can accumulate space. This script purges the recycle bin:

BEGIN
  FOR r IN (SELECT object_name FROM recyclebin) LOOP
    EXECUTE IMMEDIATE 'PURGE TABLE ' || r.object_name;
  END LOOP;
END;
/
