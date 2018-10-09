function bids_reorganization() {
	#author: daelsaid, 08/08/2018;
	#create session folders for timepoints
	#convert dicoms to nii using dcm2nii for json, else write json
	# rename task -- sub-0##_ses-0#_task-rest_run-1.nii.gz
	# make participants tsv mapping out subject id before
	# dataset description tsv
	# fmriprep
	# cpac

	subj_dir_to_org=$1
	sub_path='/data/mri/'

	find_exams_to_organize;
	for exam in $subj_dir_to_org; do
		subj_name=`mri_probedicom --i $exam/anat/001/I0001.dcm | grep PatientName | cut -d' ' -f2 | cut -d -f_ -2`;
		subj_dir=`readlink -f $(dirname $exam)/${subj_name}`;
		session=`echo ${subj_name} | cut -d_ -f3 | cut -d'p' -f2`;

		cd $(dirname $exam);

		session=`echo ${subj_name} | cut -d_ -f3 | cut -d'p' -f2`;

		subj_bids_dir=sub-0${subj_name};
		main_subj_bids_dir=${sub_path}/${subj_bids_dir}/ses-0${session};

		mkdir ${sub_path}/${subj_bids_dir};
		mkdir ${sub_path}/${subj_bids_dir}/ses-0${session};
		mkdir ${main_subj_bids_dir}/func ${main_subj_bids_dir}/fmap ${main_subj_bids_dir}/anat;

		for nii in `find . -name 'resting*' -o -name '*fspgr*' -type d -o '*20vol' -type d`; do
			cp -vr`echo $nii` ${main_subj_bids_dir}/;
			cd ${main_subj_bids_dir};
			rest_run=`echo $nii | grep 'rest*' | cut -d_ -f3`;
			mv rest*nii.gz "${subj_bids_dir}_ses-0${session}_task-rest_run-${rest_run}_bold.nii.gz"
			mv *fspgr*nii.gz "${subj_bids_dir}_ses-0${session}_T1w.nii.gz";
			#need ot understand field map specifications for b0 and ap/pa
			mv *rest_run*.* func/;
			mv *T1*nii.gz *T1*.* anat/;
			mv *fmap*.* fmap;
		done

		cd $(dirname $exam);



		cd ${subj_dir}/ses-0${session}/anat;
		mri_info ${subj_bids_dir}*T1* >> ${subj_bids_dir}*T1w.txt

		for dir in `ls -d *`; do
			echo $dir;
			seq_name=`mri_probedicom --i $dir/I0001.dcm | grep SeriesDescription | cut -d' ' -f2`;
			mkdir ../func/${seq_name};
			ionice -c 2 -n 3 cp -uvrp $dir ../func/${seq_name};
		done
		cd ${subj_dir};
		#org efiles

		for efile in `ls E*.*`; do
			seq_name=` cat $efile | grep "series description" | cut -d' ' -f4`;
			phys=`echo $efile | cut -b11-16`;
			mv *$phys* $seq_name;
		done
		mv SUMMARY summary.txt;
		cp summary.txt ${best_data_output_dir}/scan_keys/${subj_name}_scan_summary.txt;
		cd $(dirname $exam);

		ionice -c 2 -n 2 bash ${topup}/ApplyTopUp.sh ${subj_name}; #Apply topup
		topup_niis=`ls ${subj_dir}/topup/*tu.nii.gz | wc -l` # check if any topups exist
		if [[ ${topup_niis} -gt 0 ]]; then
			echo "pa/ap present"
		else

		fi
		best_village_dicom_nii_convert ${subj_dir}
		cd ${main_raw_dir};
	done &
}


docker run --rm -it -v=/home/daelsaid/Desktop/processing/ds000133:/data -v=/usr/local/freesurfer:/opt/freesurfer -v=/home/daelsaid/Desktop/processing/ds000133/derivatives:/outdir poldracklab/fmriprep /data /outdir participant --participant-label 01 --fs-license-file=/opt/freesurfer
