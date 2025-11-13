select 'ALTER DATABASE REGISTER LOGFILE '''||name||''';' from v$archived_log where applied<>'YES' order by sequence#;
