#!/bin/bash

function gen_participant_csv_and_convert_to_tsv(){
	file_to_convert=$1;
	template_scripts_path=$2;

	python ${template_scripts_path}/participant_csv_intermediate_template.py >> participants.csv;

	new_tsv_filename=`echo ${file_to_convert} | cut -d'.' -f1`;

	cat participants.csv | tr "," "\\t" >> ${new_tsv_filename}.tsv

}
