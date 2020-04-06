#!/usr/bin/python

import sys

for line in sys.stdin:
	line = line.split('\n')
	line = line[0].split('\t')
	month = line[0].split('-')
	location = line[1]+","
	ers = line[2]+","
	type = line[3]
	if month[0]!= "Dates" and location!= "Location" and ers!= "ERS" and type!="Type":
		month = month[1]+","
		print month.lower(),location.lower(),ers.lower(),type.lower()

