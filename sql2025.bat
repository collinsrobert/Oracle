

cd "D:\Install\sqlserver2025\"
setup.exe /CONFIGURATIONFILE="D:\Install\ConfigurationFile_sql2025.ini"

@Echo ################################
@Echo ################################
@Echo ################################


@Echo Done Installing SQL Server 2025 Enterprise Developer



@Echo ################################
@Echo ################################
@Echo RUNNING SSMS 21 Installation
@Echo ################################
@Echo ################################
@Echo ################################
@Echo ################################

cd "D:\Install\SSMS_Layout\"

"vs_SSMS.exe --install --quiet --noWeb --add Microsoft.Component.HelpViewer" 


@Echo ################################
@Echo ################################
@Echo ################################
@Echo ################################
@Echo Done Installing SQL Server 21 Management Studio


