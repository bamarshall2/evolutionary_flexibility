#note, for this to work, it must be in folder where orfipy outputs will land

for proteome in $(<../manifest.txt)
do
    orfipy ../genome_database/$proteome --pep $proteome.faa --min 150
done
