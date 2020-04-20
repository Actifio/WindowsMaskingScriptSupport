### Introduction

This repository contains example scripts that could be used to perform masking automated via a Windows bat file and Actifio.

The sequence of events for a workflow are:

1)  A LiveClone of the production DB is refreshed from the lastest snapshot
2)  This LiveClone is prep-mounted to a masking host where the production DB is prep-mounted as a database with a temporary name.
The workflow needs to ensure the prep-mounted DB has that name or the SQL script will fail.
3)  The workflow calls the bat file masking_update.bat as a post mount task (after the prepmount). 
4)  Once the masking is complete, the prep-mount is unmounted and the liveclone is now in a masked state.
5)  The masked liveClone can now mounted to the target host by the workflow.

This means the workflow needs to be setup as follows:

* Workflow Type:  Liveclone
* Schedule Type:  On Demand
* Mount for Pre-Processing:  On
* Post-Script:  masking_update.bat   (or whatever the bat file is called)
* Create New Virtual Application:  On
* SQL Server Database Name:  Should match the DB name in the SQL script  (Note if DB is an instance, you will need to define a prefix)

On the next panel you can set it up any way you like,  if the database is called smalldb, then ideally use something like this:

* Source DB name:      smalldb
* Prepmount DB name:   premasking 
* Final mount DB name: maskedsmalldb

### Validation

Compare the masked index ID between the source DB (i.e. smalldb) and the mounted masked copy (i.e. maskedsmalldb).

### Important details to be aware of

1)  The BAT file only runs when these are all set:   "%ACT_MULTI_OPNAME%" == "scrub-mount" if "%ACT_MULTI_END%" == "true" if "%ACT_PHASE%" == "post" 

This ensures the script only runs after all parts of the prep-mount are complete including mounting of logs and starting of prepmounted Database.

### Manual test of bat file

You can run the bat file with a parameter of 'test' to do a manual set of masking.

### Default mask command in masking_update.bat

By default this script is shown running a SQL command with a SQL script to do simple masking.   This lets you test the whole process without masking software.

1)  The SQLCMD path in the BAT file needs to be fully stated and must exist.   On some versions of SQL Server the path might be different.   
To find your sqlcmd.exe use the Windows 'where' command (its like the Unix 'which' command):

```C:\Users\av>where sqlcmd.exe
C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD.EXE```

2)  The SQLCMD has a -b to force a failure if the SQL fails.

