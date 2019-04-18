### Introduction

This script is a simple example to show how masking can be done using SQL Scripts and Actifio.
This script works with a single database called smalldb.    
smalldb is a discovered and protected database and an on-demand workflow using LiveClone has been created that does a masking pre-mount.

The sequence of events are for a workflow 

1)  A LiveClone of smalldb is refreshed from the lastest snapshot
2)  This LiveClone is prep-mounted to a masking host where smalldb is prep-mounted as a database called unmasked_smalldb
3)  The workflow calls the bat file masking_update.bat as a post mount task (after the prepmount). This bat file runs SQL commands placed in masking_test.sql
If the SQL fails the prep-mount fails.
4)  Once the masking is complete, the prep-mount is unmounted and the liveclone is now masked.
5)  The masked liveClone is now mounted to the target host as maskedsmalldb

### Validation

Compare the masked index ID between the source DB (smalldb) and the mounted masked copy (maskedsmalldb).

### Important details to be aware of

1)  The SQLCMD path in the BAT file needs to be fully stated and must exist.   On some versions of SQL Server the path might be different.   
2)  The SQLCMD has a -b to force a failure if the SQL fails.

