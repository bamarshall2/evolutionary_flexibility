# Evolutionary_flexibility
Code used to perform analysis in Evolutionary flexibility and rigidity in the bacterial MEP pathway 

# Requirements
Conda environments with: <br>
Orfipy at https://github.com/urmi-21/orfipy <br>
kofam_scan at https://github.com/takaram/kofam_scan

# Step 1: download database of genomes as fasta files
NCBI has sortable database of genomes which can be sorted for quality. I recommend you only take genomes of the highest quality and consider renaming files to be human readable. <br>
Copy genomes into "genome_database" <br>
Make manifest of genomes in this database which will be used by scripts called "manifest.txt" <br>
This can be achieved from evolutionary_flexibility folder by "ls genome_database/ >> manifest.txt"

# Step 2: use orfipy to extract open reading frames (ORFs)
In conda environment with orfipy installed <br>
Navigate into folder "extracted_orfs" <br>
Run bash file present <br>
"bash mass_run_orfipy.sh"<br>

Collect output files in "collected_orf_outputs" folder<br>
To put the output .faa files with the orfs in them, navigate to "extracted_orfs" and execute:<br>
find -name '*.faa' -exec cp -t ./collected_orf_outputs/ {} +


Make another manifest where the names are exactly captured
ls collected_orf_outputs/ >> manifest_with_extension.txt


# Step 3: construct kofam_scan "ko_list" to genes of interest
Navigate into kofam directory
Based on steps at : https://taylorreiter.github.io/2019-05-11-kofamscan/
Download ko_list <br>
"wget ftp://ftp.genome.jp/pub/db/kofam/ko_list.gz" <br>
Download hmm profiles <br>
"wget ftp://ftp.genome.jp/pub/db/kofam/profiles.tar.gz" <br>
Download kofamscan tool
"wget ftp://ftp.genome.jp/pub/db/kofam/profiles.tar.gz" <br>
This can also be achieved by downloading the kofam_scan tar.gz file in https://www.genome.jp/ftp/tools/kofam_scan/ <br>
Download readme <br>
"wget ftp://ftp.genome.jp/pub/tools/kofamscan/README.md" <br>

Consider making a new conda environment for running kofamscan. Taylor Reiter performs the following:<br>
"conda create -n kofamscan hmmer parallel"<br>
"conda activate kofamscan"<br>
"conda install -c conda-forge ruby"<br>

decompress files <br>
"gunzip ko_list.gz"<br>
"tar -xvf profiles.tar.gz"<br>
"tar -xvf kofamscan-VERSION.tar.gz"<br>

Trim ko_list to ko's of interest named "ko_list_curated"<br>
Note that the "ko_list_curated" included in this git iteration are the MEP and MVA relevant genes

In kofam_scan-VERSION edit config.yml file to reflect path to profile database and ko_list<br>
note that name must be changed to config.yml, it should not be config-template.yml<br>
config.yml should look like this:<br>

#Path to your KO-HMM database
#A database can be a .hmm file, a .hal file or a directory in which<br>
#.hmm files are. Omit the extension if it is .hal or .hmm file<br>
profile: ../profiles<br>

#Path to the KO list file<br>
ko_list: ../ko_list_curated<br>

# Step 4: Perform ortholog identification
Navigate into kofam/kofam_scan-VERSION<br>

run bash script that iteratively runs kofamscan over orf files for KO's of interest:<br>
"bash mass_run_kofam_scan.sh"






