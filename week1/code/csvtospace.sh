#script that takes a comma separated values and converts it to a space separated values file.


#check that there is a directory
if [ ! -d "../data/temperatures" ]; then
    echo "there is no directory"
else
    echo "there is a directory"
fi
 
#bash the files to convert
bash code 1800.csv 1801.csv 1802.csv 1803.csv


#converting csv to ssv
for f in "$../data/temperatures"/*.csv; do
    if [ -e "$f" ]; then
        echo "Converting $f to "../data/temperatures"/$(basename "$f" .csv).ssv"
        tr ',' ' ' < "$f" > "../data/temperatures"/$(basename "$f" .csv).ssv"
    else 
        echo "no CSV files in directory"
    fi
    
done


echo "csv file has been successfully converted into a ssv file"
