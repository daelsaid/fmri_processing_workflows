function make_bids_dir() {
	# create session folders for timepoints
    # add original id, new bids id and sessoin to participants.tsv file
    # make sub directroy with project specific ID, session,anat, func, and fmap dir subject

    path_including_dir=$1; # fll path  /pahtodir/project_given_id
    bids_dir=$2; #data directory

    for dir in `ls -d ${path_including_dir}`; do

        path=`readlink -f $path_including_dir`;
        new_id=`echo $dir | cut -d_ -f2`;
        session=`echo $dir | cut -d_ -f3 | cut -d'p' -f2`;

        echo $(basename $dir),sub-${new_id},ses-0${session} | tr "," "\\t"  >> ${bids_dir}/participants.tsv

        cd $(dirname $path);

        mkdir sub-${new_id};
        mkdir sub-${new_id}/ses-0${session};
        mkdir sub-${new_id}/ses-0${session}/func;
        mkdir sub-${new_id}/ses-0${session}/anat;
        mkdir sub-${new_id}/ses-0${session}/fmap;
    done;
}

# TO DO

for dcm_zip in  `find . -name '*.dicom.zip' -type f`; do
    uid=`unzip -l ${dcm_zip} | grep "uid" | awk -F ' ' '{ print $28}' | cut -d'"' -f2 | grep -v : | grep -v label`;
    scan_type=`unzip -l ${dcm_zip} | grep "label" | awk -F ' ' '{ print $32}' | cut -d'"' -f2`;
    resting_scans=`echo ${dcm_zip} | grep 'rest*' | cut -d_ -f3 | cut -d'p' -f2`;
done;

docker run --rm -it -v=/home/daelsaid/Desktop/processing/ds000133:/data -v=/usr/local/freesurfer:/opt/freesurfer -v=/home/daelsaid/Desktop/processing/ds000133/derivatives:/outdir poldracklab/fmriprep /data /outdir participant --participant-label 01 --fs-license-file=/opt/freesurfer
