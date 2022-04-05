#!/bin/bash

mkdir ~/S4_tmp
touch ~/S4_tmp/temp2.txt
touch ~/S4_tmp/temp4.txt
touch ~/S4_tmp/temp_sed.txt

ps -eo user= | sort | uniq -c | rev | cut -d ' ' -f 2,1 | rev  | sort -r |  cat > ~/S4_tmp/temp.txt

ile=$(wc -l ~/S4_tmp/temp.txt | cut -d ' ' -f 1)
cat ~/S4_tmp/temp.txt | cut -d ' ' -f 1 | cat >> ~/S4_tmp/temp2.txt
suma=$(paste -sd+ ~/S4_tmp/temp2.txt | bc)

echo ""
echo -e "\t\t Uruchomione procesy:"
echo ""

for((i=1; i<=ile; i++))
do

	uzytkownik=$(cat ~/S4_tmp/temp.txt | cut -d ' ' -f 2 | head -${i} | tail -1)
	procesy=$(cat ~/S4_tmp/temp.txt | cut -d ' ' -f 1 | head -${i} | tail -1)
	val=$((procesy/suma))
	let "a=$procesy*100"
	var=$(awk -v var1=$a -v var2=$suma 'BEGIN {print ( var1 / var2 )}')
	#var=$(echo "scale=3; $a/$suma" | bc -l)

echo -e "${uzytkownik}|$procesy|${var}%" | cat >> ~/S4_tmp/temp3.txt


done
sed 's/||/| |/g;s/||/| | /g' ~/S4_tmp/temp3.txt | column -s"|" -t | less -#2 -N -S | cat > ~/S4_tmp/temp_sed.txt
cat ~/S4_tmp/temp_sed.txt

echo ""
echo -e "\t\t   SUMA: $suma"
echo ""
echo -e  "\t\t    Wykres:"
echo ""

for((i=1; i<=ile; i++))
do
	uzytkownik=$(cat ~/S4_tmp/temp.txt | cut -d ' ' -f 2 | head -${i} | tail -1)
	procesy=$(cat ~/S4_tmp/temp.txt | cut -d ' ' -f 1 | head -${i} | tail -1)
	wykres=" "
	
	for((j=1; j<=procesy; j++))
	do
		wykres+="*"
	done
	
	echo -e "$wykres     $uzytkownik"
done

echo ""

rm -r ~/S4_tmp

