# -*- coding: utf-8 -*-
"""
Created on Thu Jan 11 10:47:35 2018

@author: Daan
"""
# opening the packages and opening the file
import json
import csv
with open('conflict_data_full_lined.json') as conflictfile :
    conflictdata = json.load(conflictfile)
  
#with open('conflict_sample.json') as samplefile :  ## this was a sampledata file to try code with, to prevent 
#   sampledata = json.load(samplefile)              ## the computer from crashing on the large file

# isolating the values from the dictionaries in 'conflictdata', putting them as lists into a new list of 'values'
values = []
for dictionaries in conflictdata:
    if dictionaries['country'] == 'Afghanistan':
        values.append([dictionaries['id'], dictionaries['year'], dictionaries['conflict_new_id'], 
        dictionaries['type_of_violence'], dictionaries['side_a'], dictionaries['side_b'], dictionaries['latitude'],
        dictionaries['longitude'], dictionaries['country'], dictionaries['country_id'], dictionaries['dyad_name'],
        dictionaries['deaths_a'], dictionaries['deaths_b'], dictionaries['deaths_civilians']])
        
    
#writing to the .csv file (for R analysis)
#first writes a .csv file called 'python_conflict_data', then makes a row with the column headers,
#then writes the other rows with the relevant columns, every row is the data for every new conflict
with open('python_conflict_data.csv', 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile, delimiter=',', quotechar='"', quoting=csv.QUOTE_NONNUMERIC)
    csvwriter.writerow(['id', 'year', 'conflict_new_id', 'type_of_violence', 'side_a', 'side_b',
                        'latitude', 'longitude', 'country', 'country_id', 'dyad_name', 'deaths_a', 'deaths_b',
                        'deaths_civilians'])
    csvwriter.writerows(values)

    