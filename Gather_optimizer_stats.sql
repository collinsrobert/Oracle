/*

script for gathering optimizer statistics. This script will help ensure that the query optimizer has up-to-date statistics for efficient query planning.




*/




BEGIN
  DBMS_STATS.GATHER_DATABASE_STATS(
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    method_opt => 'FOR ALL COLUMNS SIZE AUTO',
    degree => DBMS_STATS.DEFAULT_DEGREE,
    cascade => TRUE
  );
END;
/
