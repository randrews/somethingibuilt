#!/bin/bash

sudo service unicorn_somethingibuilt force-stop
sleep 3
sudo service unicorn_somethingibuilt start
