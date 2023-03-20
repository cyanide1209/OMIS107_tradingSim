echo "Enter a ticker symbol:"
read d

./ticker.sh $d > file
./cleanfile.sh < file > new

x=$(date | sed "s/:[0-9]* .*//g" | sed "s/...........//g" | sed "s/://g")
echo Dates and times are in UTC: 13:30-20:00 in UTC represents 9:30am-4pm which is when the stock market runs 
while [ $x -le 1330 ]
do
        sleep 60
        x=$(date | sed "s/:[0-9]* .*//g" | sed "s/...........//g" | sed "s/://g")
done
while [ $x -ge 1330 -a $x -le 2000 ]
do
    if [ $(date | sed "s/:[0-9]* .*//g" | sed "s/...........//g" | sed "s/://g") -ne $x ]
    then
        cat new | awk -v x="`date|sed "s/:[0-9]* .*//g"`" '{print x"----"$2}' | sed "s/^....//g" >> newfile
        ./ticker.sh $d > file
        ./cleanfile.sh < file > new
        x=$(date | sed "s/:[0-9]* .*//g" | sed "s/...........//g" | sed "s/://g")
    fi
done
