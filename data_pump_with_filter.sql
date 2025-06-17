expdp username/password DUMPFILE=INVeNTORY_DEtail_history.dmp LOGFILE=edwnew_FACT_INVeNTORY_DEtail_history_edwp01.log DIRECTORY=DP_DIR PARALLEL=4 TABLES='schema_name.INVeNTORY_DEtail_history' QUERY="\"where snapshot_date_key >= TO_CHAR(ADD_MONTHS(SYSDATE, -15), 'YYYYMMDD')\""

---This is a pump filtering 15 months of data



[EDW TEST oracle@vtlledworan002]$cat impdp_edwnew_fact_inventory_history_detail_ddl.sh


impdp  username/password  DUMPFILE=edwnew_FACT_INVeNTORY_DEtail_history_edwp01.dmp LOGFILE=edwnew_FACT_INVeNTORY_DEtail_history_edwt01.log TABLES='EDWNEW.FACT_INVENTORY_DETAIL_HISTORY' REMAP_TABLE='EDWNEW.FACT_INVENTORY_DETAIL_HISTORY:FACT_INVENTORY_DETAIL_HISTORY_DDL' PARALLEL=4 DIRECTORY=DP_DIR CONTENT=DATA_ONLY
