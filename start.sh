#!/bin/sh

screen -S cms -dm bash -c "cd sahara-cms; rackup -p 30301"
screen -S pms -dm bash -c "cd sahara-pms; rackup -p 30302"
screen -S oms -dm bash -c "cd sahara-oms; rackup -p 30303"
python -m SimpleHTTPServer
