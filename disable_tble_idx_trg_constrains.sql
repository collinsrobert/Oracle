--DISABLE
 
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql += 'ALTER INDEX ' + QUOTENAME(i.name) + ' ON ' + QUOTENAME(s.name) + '.' + QUOTENAME(o.name) + ' DISABLE;' + CHAR(13) + CHAR(10)
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE i.type_desc = 'NONCLUSTERED'
AND o.name = 'TABLE_NAME'
AND s.name = 'SCHEMA_NAME';
EXEC sp_executesql @sql;
 
-- Disable constraints for TABLE_NAME
ALTER TABLE [SCHEMA_NAME].TABLE_NAME NOCHECK CONSTRAINT ALL;
 
-- Disable triggers for DIM_QUESTION
DISABLE TRIGGER ALL ON [SCHEMA_NAME].FACT_FIVE9_DIGITAL_AGENT;
 
 
--ENABLE
 
-- Enable non-clustered indexes, constraints, and triggers for TABLE_NAME:
ALTER INDEX ALL ON SCHEMA_NAME.TABLE_NAME REBUILD;
ALTER TABLE SCHEMA_NAME.TABLE_NAME CHECK CONSTRAINT ALL;
ENABLE TRIGGER ALL ON SCHEMA_NAME.TABLE_NAME;
 
 ---###################################################################
