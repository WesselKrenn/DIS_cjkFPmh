#!/bin/sh
psql -d uni -f /home/student/2ID70/createTables.sql
psql -d uni -f /home/student/2ID70/loadData.sql
