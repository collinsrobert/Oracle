--cat standby_mrp.sql
alter database recover managed standby database using current logfile disconnect;
