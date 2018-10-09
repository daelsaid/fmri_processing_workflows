import os
import collections
import json

data = collections.OrderedDict()

data["Name"] = ''
data["Description"] = ''
data["BIDSVersion"] = '1.0.0rc3'
data["License"] = ''
data["Authors"] = ['']
data["Funding"] = ''
data["ReferencesAndLinks"] = ['']
data['HowToAcknowledge'] = ''
data['DatasetDOI'] = ''

bids_dir = ''
project_subject_label = ''
dataset_json_folder = bids_dir + project_subject_label
dataset_json_name = dataset_json_folder + '/' + 'dataset_description.json'

with open(dataset_json_name, 'w') as ff:
    json.dump(data, ff, sort_keys=False, indent=4)
