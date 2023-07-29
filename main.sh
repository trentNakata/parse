length=$(wc -l test.txt | awk -F " " '{print $1}')

newGame=false
homeBatter=1
visitorBatter=1

for ((i = 1; i < length; i++));
do
year=$(awk -F '|' 'NR==i {print $10}' i="${i}" test.txt)
date=$(awk -F '|' 'NR==i {print $1}' i="${i}" test.txt)
id=$(awk -F '|' 'NR==i {print $12}' i="${i}" test.txt)
inning=$(awk -F '|' 'NR==i {print $4}' i="${i}" test.txt)
away_score=$(awk -F '|' 'NR==i {print $6}' i="${i}" test.txt|awk -F '-' '{print $1}')
home_score=$(awk -F '|' 'NR==i {print $6}' i="${i}" test.txt|awk -F '-' '{print $2}')
batter_name=$(awk -F '|' 'NR==i {print $13}' i="${i}" test.txt)
top_inning=$(awk -F '|' 'NR==i {print $5}' i="${i}" test.txt)
#test_text=$(awk -F '/' 'NR==i {print $9}' i="${i}" test.txt | awk -F '.' '{print$2}')
if [ "$top_inning" = "top" ]; then
    top=1
    if [ ! -z "$test_text" ]; then
        away_text=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt)
        home_text=""
        bat_order=visitorBatter
        visitorBatter++
    fi
    if [ "$visitorBatter" -eq 10 ]; then
        visitorBatter=1
    fi
else
    top=0
    away_text=""
    if [ ! -z "$test_text" ]; then
        home_text=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt)
        bat_order=homeBatter
        homeBatter=$((homeBatter+1))
    fi
    if [ "$homeBatter" -eq 10 ]; then
        homeBatter=1
    fi
fi

second=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'second' '{print $1}' | awk -F ';' '{print $NF}' | awk '$3 ~ /advanced/' | awk -F 'advanced' '{print $1}')
third=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt  | awk -F 'rd' '{print $1}' | awk -F ';' '{print $NF}' | awk '$5 ~ /thi/' | awk '$3 ~ /advanced/' | awk -F 'advanced' '{print $1}')

sub='third'

#if [[ "$test_text" == *"sub"* ]]; then
#    echo hello
#  third=$(awk -F '/' 'NR==i {print $9}' i="${i}" test.txt  | awk -F 'third' '{print$1}' | awk -F ';' '{print $NF}' | awk '$3 ~ /advanced/' | awk -F 'advanced' '{print $1}')
#fi

#echo $third

#test_text=$(awk -F '/' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'walked' '{print$1}' | awk '$3 ~ /to/' | awk -F 'to' '{print $1}')

#echo "$test_text"

#test_text=$(awk -F '/' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'walked' '{print$1}' | awk -F ';' '{print $NF}' | awk '$3 ~ /advanced/' | awk -F 'advanced' '{print $1}')

#test_text=$(awk -F '/' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'walked' '{print$1}' | awk '$3 ~ /to/' | awk -F 'to' '{print $1}')
sub_in=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'walked' '{print$1}' | awk '$3 ~ /to/' | awk -F 'for' '{print $2}')


echo "$year|$date|$id|$visitor|$home|$inning|$top|$away_score|$home_score|$away_text|$home_text|$bat_order|$battername|$1st|$2nd|$3rd|$subnum|$sub_in"

done >> final.txt


#home_text need to check which innig logic


#cat test.txt | while read LINE ; do
#echo $(awk -F '/' '{print $10}' test.txt)
#done