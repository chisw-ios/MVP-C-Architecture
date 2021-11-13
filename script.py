#!/usr/bin/env python3

import yaml
from pathlib import Path

fname = "project.yml"

stream = open(fname, 'r')
data = yaml.safe_load(stream)

newProjectName = input('What is yout project name? \n>>>   ')
data['name'] = newProjectName
data['options']['bundleIdPrefix'] = 'com.' + newProjectName

targetKeys = data['targets']
for key, value in targetKeys.items():
    targetKey = key
data['targets'][newProjectName] = data['targets'][targetKey]
data['targets'].pop(targetKey, None)

my_path = Path().resolve()
data['targets'][newProjectName]['sources'][0]['path'] = str(my_path) + '/Source'
data['targets'][newProjectName]['sources'][0]['name'] = newProjectName

with open(fname, 'w') as yaml_file:
    yaml_file.write( yaml.dump(data, default_flow_style=False, sort_keys=False))
