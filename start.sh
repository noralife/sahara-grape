#!/bin/sh

screen -S cms -dm bash -c "cd sahara-cms; rackup -p 3001"
screen -S pms -dm bash -c "cd sahara-pms; rackup -p 3002"
screen -S oms -dm bash -c "cd sahara-oms; rackup -p 3003"
python -m SimpleHTTPServer
