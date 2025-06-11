select JOB,LAST_DATE,THIS_DATE,NEXT_DATE,BROKEN,FAILURES,WHAT from dba_jobs where failures>0; 
select count(*) NumberOfFailures from dba_jobs where FAILURES>0
