create role r_non_viewable_tables authorization dbo
go
deny view definition on [SCHEMA_NAME].[TABLE_NAME] to r_non_viewable_tables
 

select 'alter role r_non_viewable_tables add member ['+name+']' from sys.database_principals d where d.type<>'R' and name not in ('username','sys','dbo','guest','INFORMATION_SCHEMA')
