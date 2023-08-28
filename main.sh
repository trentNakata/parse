length=$(wc -l test.txt | awk -F " " '{print $1}')

newGame=false
homeBatter=1
visitorBatter=1

for ((i = 1; i <= length; i++));
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
        bat_order=$visitorBatter
        visitorBatter=$((visitorBatter+1))
    fi

    if [ "$visitorBatter" -eq 10 ]; then
        visitorBatter=1
    fi
else

    top=0
    away_text=""
    if [ ! -z "$test_text" ]; then
        home_text=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt)
        bat_order=$homeBatter
        homeBatter=$((homeBatter+1))
    fi
    if [ "$homeBatter" -eq 10 ]; then
        homeBatter=1
    fi
fi

sub='third'
sub_in=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'walked' '{print$1}' | awk '$3 ~ /to/' | awk -F 'for' '{print $2}')

third=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt  | awk -F 'rd' '{print $1}' | awk -F ';' '{print $NF}' | awk '$5 ~ /thi/' | awk '$3 ~ /advanced/' | awk -F 'advanced' '{print $1}')
second=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'second' '{print $1}' | awk -F ';' '{print $2}' | awk -F 'advanced' '{print $1}')
first=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk /walked/ | awk -F 'walked' '{print $1}')

test_text=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk -F 'pitch' '{print $2}')

if [[ -z "$first" ]]; then
    first=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk /pitch/ | awk -F 'hit' '{print $1}')
fi

if [[ -z "$first" ]]; then
    first=$(awk -F '|' 'NR==i {print $9}' i="${i}" test.txt | awk /singled/ | awk -F 'single' '{print $1}')
fi

echo "$year|$date|$id|$visitor|$home|$inning|$top|$away_score|$home_score|$away_text|$home_text|$bat_order|$battername|$first|$second|$third|$subnum|$sub_in"
done >> final.txt