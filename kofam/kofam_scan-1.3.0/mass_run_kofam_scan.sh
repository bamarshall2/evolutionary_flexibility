#!/bin/bash

for proteome in $(<../../manifest_with_extension.txt)
do 
    ./exec_annotation --format=detail-tsv -o ../../output_files/$proteome ../../extracted_orfs/collected_orf_outputs/$proteome
done

