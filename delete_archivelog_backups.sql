crosscheck backup;
crosscheck archivelog all;
delete noprompt backup;
delete noprompt archivelog until time 'sysdate - 1' ;

crosscheck backup;
delete noprompt obsolete;
