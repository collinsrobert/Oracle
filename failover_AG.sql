 SELECT 
    ag.name AS AG_Name,
    ar.replica_server_name AS Replica,
    ars.role_desc AS Role,
    ars.synchronization_health_desc AS SyncState
FROM 
    sys.availability_groups ag
JOIN 
    sys.availability_replicas ar ON ag.group_id = ar.group_id
JOIN 
    sys.dm_hadr_availability_replica_states ars ON ar.replica_id = ars.replica_id
 
 
 
 declare @agName varchar(max)

    select @agName='alter availability group ['+  ag.name+'] FAILOVER;' from   
    sys.availability_groups ag
  exec(@agName)


  -- Get AG and Replica state
SELECT 
    ag.name AS AG_Name,
    ar.replica_server_name AS Replica,
    ars.role_desc AS Role,
    ars.synchronization_health_desc AS SyncState
FROM 
    sys.availability_groups ag
JOIN 
    sys.availability_replicas ar ON ag.group_id = ar.group_id
JOIN 
    sys.dm_hadr_availability_replica_states ars ON ar.replica_id = ars.replica_id
