SELECT tablespace_name,
       tablespace_size / 1024 / 1024 AS total_mb,
       allocated_space / 1024 / 1024 AS used_mb,
       free_space / 1024 / 1024 AS free_mb
FROM   dba_temp_free_space;
