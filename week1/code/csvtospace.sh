#script that takes a comma separated values and converts it to a space separated values file.
#directoty
cd ~/Documents/CMEECourseWork/week1

#input directory 
dir_input="/home/anna/Documents/CMEECourseWork/week1/data/temperatures"
#output directory
dir_output="/home/anna/Documents/CMEECourseWork/week1/data/temperatures"

#check that there is a directory
if [ ! -d "$dir_input" ]; then
    echo "there is no directory"
else
    echo "there is a directory"
fi
 
#bash the files to convert
bash code 1800.csv 1801.csv 1802.csv 1803.csv


#converting csv to ssv
for f in "$dir_input"/*.csv; do
    if [ -e "$f" ]; then
        echo "Converting $f to $dir_output/$(basename "$f" .csv).ssv"; 
        tr ',' ' ' < "$f" > "$dir_output/$(basename "$f" .csv).ssv"
    else 
        echo "no CSV files in directory"
    fi
    
done


echo "csv file has been successfully converted into a ssv file"
