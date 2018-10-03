#!/bin/bash

function gen_participant_csv_and_convert_to_tsv(){
	file_to_convert=$1;
	python /Users/daelsaid/scripts/bids/templates/create_participant_csv_intermediate.py >> participants.csv;
	new_tsv_filename=`echo ${file_to_convert} | cut -d'.' -f1`;
	cat ${file_to_convert} | tr "," "\\t" >> ${new_tsv_filename}.tsv
}
gen_participant_csv_and_convert_to_tsv
