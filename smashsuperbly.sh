echo this script runs on the stock from problem1script
echo please enter a percent increase to test e.g. a 1% increase would be .01:
read z
echo please enter a time you want to hold a stock
read hold_time
hold=0
purchase_time=0
purchase_price=0
x=$(date '+%H%M'|sed "s/^0*//g") 
while [ $x -le 1331 ]
do
        sleep 60
        x=$(date '+%H%M'|sed "s/^0*//g")
done
y=$(cat newfile|wc -l)
while (( $x >= 1331 && $x <= 2000 ))
do 
        if [[ "$(date '+%H%M'|sed "s/^0*//g")" != "$x" ]]
        then
                cur_price=$(cat newfile | tail -1| sed "s/.*----//g")
                if [[ $hold -eq 0 ]]
                then 
                        prev_price=$(cat newfile | tail -2 | head -1|sed "s/.*----//g")
                        inc_perc=$(echo "($cur_price-$prev_price)/$prev_price" | bc -l)
                        if (( $(echo "$inc_perc >= $z" | bc -l) ))
                        then 
                                hold=1
                                purchase_price=$cur_price
                                purchase_time=$x
                        fi
                fi
                if [ $hold -eq 1 ]
                then
                        if [ "$(echo "$x == $purchase_time + $hold_time" | bc -l)" -eq 1 ]
                        then
                                hold=0
                                echo $cur_price-$purchase_price
                                echo $(date| sed "s/:[0-9]* .*//g"| sed "s/...........//g"): Over the past $hold_time minutes: you made $(echo "$cur_price-$purchase_price" | bc -l) >> portfolio  
                        fi
                fi
                x=$(date '+%H%M'| sed "s/^0*//g")
        else 
                sleep 60
        fi
done
