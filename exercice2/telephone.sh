#!/bin/bash

awk -F ';' '{gsub(/\+33/, "0", $7)} 1' fake-users-base.csv

