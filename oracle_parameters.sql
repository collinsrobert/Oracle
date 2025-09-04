Run the following

alter system set remote_os_authent=TRUE scope=spfile;
alter system set os_authent_prefix='DOMAIN\' scope=spfile;
alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.1.0.0)(PORT=1521))' scope=both;
alter system set service_names='node' scope=both;
alter system set smtp_out_server='smtp.com' scope=both;
alter system set db_domain='' scope=spfile; This caused us grief the last time because we missed it.

Run this on the node1
alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=node1)(PORT=1521))' scope=both sid='node11';

Run this on node2
alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=node2)(PORT=1521))' scope=both sid='node12';

Stop/restart cluster and test remote connection


Modify parameters below
Note: do on both tst11 and tst12
alter system set optimizer_index_cost_adj=90 scope=both;
alter system set optimizer_mode='CHOOSE' scope=both;
alter system set optimizer_index_caching=10 scope=both;
