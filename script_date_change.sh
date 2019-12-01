

while read line; do
echo "$line"
date=$(echo "$line" | cut -d/ -f1 )
month=$(echo "$line" | cut -d/ -f2 )
echo "date" $date
echo "month" $month
echo $month"/"$date"/2017"
done </home/danrox/Desktop/Dates.csv
