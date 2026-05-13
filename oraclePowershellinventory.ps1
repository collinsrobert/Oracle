Add-Type -Path "N:\oracle\193000_client\client\ODP.NET\managed\common\Oracle.ManagedDataAccess.dll"

# =========================
# SQL Server settings
# =========================
$sqlServer = "ServerName"
$sqlDb     = "INVENTORYDB"

# =========================
# credentials
# =========================
$credRow = Invoke-Sqlcmd `
    -Query "SELECT TOP 1 id, TexMex FROM DB_INVENTORY.dbo.tb_Oracreds" `
    -ServerInstance $sqlServer `
    -Database $sqlDb `
    -TrustServerCertificate

$user = $credRow.id.ToString().Trim()
$pass = $credRow.TexMex.ToString().Trim() -replace "`r|`n",""

# =========================
# Oracle servers
# =========================
$servers = Invoke-Sqlcmd `
    -Query "SELECT connect_data FROM DB_INVENTORY.dbo.tb_oracle_databases" `
    -ServerInstance $sqlServer `
    -Database $sqlDb `
    -TrustServerCertificate

# =========================
# Oracle query (FIXED)
# =========================
$cmdText = @"
SELECT
     instance_name,
     host_name,
     instance_role,
     edition,
     database_type,
     status,
     version,
     startup_time,
     logins
FROM v`$instance  
"@

foreach ($server in $servers) {

    $conn = $null

    try {

        $connectData = $server.connect_data.ToString().Replace("`r","").Replace("`n"," ")

        # Oracle connection
        $csb = New-Object Oracle.ManagedDataAccess.Client.OracleConnectionStringBuilder
        $csb.set_UserID($user)
        $csb.set_Password($pass)
        $csb.set_DataSource($connectData)

        $conn = New-Object Oracle.ManagedDataAccess.Client.OracleConnection($csb.ConnectionString)
        $conn.Open()

        $cmd = $conn.CreateCommand()
        $cmd.CommandText = $cmdText

        $reader = $cmd.ExecuteReader()

        while ($reader.Read()) {

            $instanceName = $reader["INSTANCE_NAME"]
            $hostName     = $reader["HOST_NAME"]
            $role         = $reader["INSTANCE_ROLE"]
            $edition      = $reader["EDITION"]
            $dbType       = $reader["DATABASE_TYPE"]
            $status       = $reader["STATUS"]
            $version      = $reader["VERSION"]
            $startup      = $reader["STARTUP_TIME"]
            $logins       = $reader["LOGINS"]

            # =========================
            # INSERT INTO SQL SERVER
            # =========================
            $insert = @"
INSERT INTO dbo.tb_Oracle_Instance_Snapshot
(
    InstanceName,
    HostName,
    InstanceRole,
    Edition,
    DatabaseType,
    Status,
    Version,
    StartupTime,
    Logins,
    ServerName
)
VALUES
(
    '$instanceName',
    '$hostName',
    '$role',
    '$edition',
    '$dbType',
    '$status',
    '$version',
    '$startup',
    '$logins',
    '$connectData'
)
"@

            Invoke-Sqlcmd `
                -ServerInstance $sqlServer `
                -Database $sqlDb `
                -Query $insert `
                -TrustServerCertificate
        }

        $reader.Close()

        Write-Host "SUCCESS: $connectData" -ForegroundColor Green
    }
    catch {
        Write-Host "FAILED: $connectData" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
    finally {
        if ($conn -ne $null -and $conn.State -eq 'Open') {
            $conn.Close()



  #####################################

  <#
    This is a block comment.
    It can span multiple lines.
    Useful for detailed notes or disabling chunks of code.

    
CREATE TABLE [dbo].[tb_Oracle_Instance_Snapshot](
	[InstanceName] [nvarchar](100) NULL,
	[HostName] [nvarchar](200) NULL,
	[InstanceRole] [nvarchar](50) NULL,
	[Edition] [nvarchar](50) NULL,
	[DatabaseType] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Version] [nvarchar](100) NULL,
	[StartupTime] [datetime] NULL,
	[Logins] [nvarchar](50) NULL,
	[ServerName] [nvarchar](200) NULL,
	[CollectedAt] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_Oracle_Instance_Snapshot] ADD  DEFAULT (getdate()) FOR [CollectedAt]
GO
##########################################################################################################



/****** Object:  Table [dbo].[tb_Oracreds]    Script Date: 5/12/2026 9:24:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Oracreds](
	[id] [varchar](50) NULL,
	[TexMex] [nvarchar](100) NULL
) ON [PRIMARY]
GO


########################################################################################################


CREATE TABLE [dbo].[tb_oracle_databases](
	[server_monitoring_id] [int] IDENTITY(1,1) NOT NULL,
	[server_name] [varchar](100) NOT NULL,
	[db_Service_name] [varchar](100) NULL,
	[connect_data] [varchar](300) NOT NULL,
	[db_type] [char](2) NOT NULL,
	[active] [char](1) NOT NULL,
	[created_on] [datetime] NOT NULL,
	[notification_age] [int] NULL,
	[last_notification] [datetime] NULL,
	[Monitored] [char](1) NULL,
	[Notes] [varchar](max) NULL
) ON [PRIMARY]
#>

  
        }
    }
}
