import pandas as pd
import os
import csv

data_dir='/Volumes/lil_baby/data/'

subjects_to_organize=os.listdir(data_dir)
len_dirs=range(1,len(subjects_to_organize),1)

subj_with_bids_id=zip(subjects_to_organize,len_dirs)

print 'participant_id,','session,','study_specific_id'
for x in subj_with_bids_id:
    subject=x[0]
    bids=x[1]
    id=subject.split('_')[1]
    tp=subject.split('_')[2]
    study_specific_id='sub-'+str(id)+'_'+tp
    bids_specific_id='sub-'+'0'+str(bids)
    bids_session='ses-0'+tp.split('p')[1]
    row=bids_specific_id+','+study_specific_id+','+bids_session
    print row
