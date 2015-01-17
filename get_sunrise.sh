#! /bin/bash

wget -O sr.html "http://aa.usno.navy.mil/rstt/onedaytable?form=1&ID=AA&year=2015&month=1&day=10&state=OR&place=portland"

grep Sunrise sr.html | cut -d">" -f5 | cut -d"<" -f1 > sunrisetime
