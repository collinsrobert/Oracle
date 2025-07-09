select * from dba_datapump_jobs;

---replace atach below with value of job_name from query above. Then run below using the userid that executed the job

 impdp userid=\'/ as sysdba\' attach=SYS_IMPORT_FULL_01

OR

impdp  user/password attach=SYS_IMPORT_FULL_01
