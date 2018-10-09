import os
import collections
import json


data = collections.OrderedDict()

data["Manufacturer"]=
data["NumberOfSlices"]=
data["MagneticFieldStrength"]=
data["RepetitionTime"]=
data["EchoTime"]=
data["NumberOfVolumesDiscardedByScanner"]=''
data["FlipAngle"]=
data["AcquisitionDuration"]=
data["NumberOfVolumesDiscardedByUser"]= ''
data["MultibandAccelerationFactor"]=
data["PhaseEncodingDirection"]=''
data["InstitutionName"]= ''
data["PercentPhaseFOV"]=
data["AcquisitionMatrixPE"]=
data["ReconMatrixPE"]=
data["PixelBandwidth"]=
data["InPlanePhaseEncodingDirectionDICOM"]=''
data["InversionTime"]=
data["PatientPosition"]=''

bids_dir = ''
project_subject_label = ''
dataset_json_folder = bids_dir + project_subject_label
dataset_json_name=dataset_json_folder+'/'+'T1w.json'

with open(dataset_json_name, 'w') as ff:
    json.dump(data, ff,sort_keys=False, indent=4)
