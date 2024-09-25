/*
Lists full backups
*/

select start_time,end_time,output_device_type,input_type,status,time_taken_display,input_bytes_display,output_bytes_display from V$RMAN_BACKUP_JOB_DETAILS where input_type='DB FULL' order by start_time desc;
