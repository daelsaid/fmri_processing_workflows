import os
import collections
import json


data = collections.OrderedDict()

data["Name"] = 'best'
data["Description"] = 'test'
data["BIDSVersion"] = '1.0.0rc3'
data["License"] = 'test'
data["Authors"] = ['test']
data["Funding"] = 'cvb'
data["ReferencesAndLinks"] = ['test']
data['HowToAcknowledge'] = 'test'
data['DatasetDOI'] = 'test'

root_dir = '/Volumes/lil_baby/data/'
project_label = 'best_3026_tp1_fmri'
dataset_json_folder = root_dir + project_label
dataset_json_name = dataset_json_folder + '/' + 'dataset_description.json'


with open(dataset_json_name, 'w') as ff:
    json.dump(data, ff, sort_keys=False, indent=4)
