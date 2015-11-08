#!/bin/sh

screen -S cms -dm bash -c "cd sahara-cms; rackup -p 9393"
screen -S pms -dm bash -c "cd sahara-pms; rackup -p 9494"
screen -S oms -dm bash -c "cd sahara-oms; rackup -p 9595"
python -m SimpleHTTPServer
