#!/bin/sh
# This script will create the tables and load all data. A sample template follows, but feel free to merge the two files.
# The script will be given 20 minutes and killed afterwards
# Expected size of tables after loading should be below 8 GB
# The total disk space available for storing all data, views, indices, and the write-ahead-log (also see UNLOGGED keyword) is 12 GB

psql -d test2 -f /home/student/Downloads/2ID70-group-08-master/createTables.sql
psql -d test2 -f /home/student/Downloads/2ID70-group-08-master/loadData.sql
