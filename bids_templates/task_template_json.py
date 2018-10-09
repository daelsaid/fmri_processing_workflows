import os
import collections
import json

data = collections.OrderedDict()

data["TaskName"]= ''
data["TaskDescription"]= ''
data["Manufacturer"]=
data["NumberOfSlices"]=
data["MagneticFieldStrength"]=
data["ManufacturersModelName"]=''
data["RepetitionTime"]=
data["EchoTime"]=
data["NumberOfVolumesDiscardedByScanner"]=
data["FlipAngle"]=
data["AcquisitionDuration"]=
data["NumberOfVolumesDiscardedByUser"]= ''
data["MultibandAccelerationFactor"]=
data["PhaseEncodingAxis"]=''
data["InstitutionName"]= ''
data["SliceThickness"]=
data["SpacingBetweenSlices"]=
data["PercentPhaseFOV"]=
data["AcquisitionMatrixPE"]=
data["ReconMatrixPE"]=
data["EffectiveEchoSpacing"]=
data["TotalReadoutTime"]=
data["PixelBandwidth"]=
data["MRAcquisitionType"]=
data["PatientPosition"]=

bids_dir = ''
project_subject_label = ''
dataset_json_folder = bids_dir + project_subject_label
dataset_json_name=dataset_json_folder+'/'+'task-rest_bold.json'

with open(dataset_json_name, 'w') as ff:
    json.dump(data, ff,sort_keys=False, indent=4)
