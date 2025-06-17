expdp username/password DUMPFILE=INVeNTORY_DEtail_history.dmp LOGFILE=edwnew_FACT_INVeNTORY_DEtail_history_edwp01.log DIRECTORY=DP_DIR PARALLEL=4 TABLES='schema_name.INVeNTORY_DEtail_history' QUERY="\"where snapshot_date_key >= TO_CHAR(ADD_MONTHS(SYSDATE, -15), 'YYYYMMDD')\""

---This is a pump filtering 15 months of data



--cat  You import and remap sourec table to a different target table


impdp  username/password  DUMPFILE=edwnew_FACT_INVeNTORY_DEtail_history_edwp01.dmp LOGFILE=edwnew_FACT_INVeNTORY_DEtail_history_remapped.log TABLES='schema_name.FACT_INVENTORY_DETAIL_HISTORY' REMAP_TABLE='schema_name.FACT_INVENTORY_DETAIL_HISTORY:FACT_INVENTORY_DETAIL_HISTORY_DDL' PARALLEL=4 DIRECTORY=DP_DIR CONTENT=DATA_ONLY
