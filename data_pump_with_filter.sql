expdp username/password DUMPFILE=INVeNTORY_DEtail_history.dmp LOGFILE=edwnew_FACT_INVeNTORY_DEtail_history_edwp01.log DIRECTORY=DP_DIR PARALLEL=4 TABLES='schema_name.INVeNTORY_DEtail_history' QUERY="\"where snapshot_date_key >= TO_CHAR(ADD_MONTHS(SYSDATE, -15), 'YYYYMMDD')\""

---This is a pump filtering 15 months of data
