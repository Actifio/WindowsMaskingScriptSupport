### Introduction

This script is a simple example to show how masking can be done using SQL Scripts and Actifio.
This script works with a single database called BikeStores.    
BikeStores is a discovered and protected database and an on-demand workflow using LiveClone has been created that does a masking pre-mount.

The sequence of events are for a workflow 

1)  A LiveClone of BikeStores is refreshed from the lastest snapshot
2)  This LiveClone is prep-mounted to a masking host where BikeStores is prep-mounted as a database called unmasked_BikeStores
3)  The workflow calls the bat file masking_update.bat as a post mount task (after the prepmount). This bat file runs SQL commands placed in masking_test.sql
If the SQL fails the prep-mount fails.
4)  Once the masking is complete, the prep-mount is unmounted and the liveclone is now masked.
5)  The masked liveClone is now mounted to the target host as maskedBikeStores 

### Validation

Compare the masked index ID between the source DB (BikeStores) and the mounted masked copy (maskedBikeStores).