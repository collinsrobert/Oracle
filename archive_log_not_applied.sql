--cat archive_log_not_applied.sql
select sequence#,applied,status from v$archived_log where applied<>'YES' order by sequence#;
