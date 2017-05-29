import sys
import os
import glob
import csv
argc = len(sys.argv)
if (argc == 1):
	print 'path is missing'
	sys.exit(-1)
if (argc > 2):
	print 'too much parameters'
	
	
path = sys.argv[1];
print 'scan files from ' + path + ":"
files = os.listdir(path)
count = 0
dict = dict()

for file in files:
	if file.endswith(".csv"):
		print path + '\\' + file
		with open(path + '\\' + file) as csvfile:
			count = count + 1
			next(csvfile)
			spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
			for row in spamreader:
				if int(row[0]) in dict:
					if dict[int(row[0])][0] == row[1]:
						dict[int(row[0])].append(row[1])
				else:
					dict[int(row[0])] = [row[1]]		
print "there is " + str(len(dict)) + " samples"
print "there is " + str(count) + " files"
towrite = []
file = open('newtests.csv', 'w')
testsCreated = 0
for index in dict:
	if len(dict[index]) == count:
		file.write(str(index) + "," + dict[index][0] + "\n")
		testsCreated = testsCreated +1
file.close()
print str(testsCreated) + " tests created"