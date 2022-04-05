#!/bin/bash

touch ~/temp.k1

cat /usr/share/dict/words | grep -o . | sort | uniq -c | sort -r | tr -s ' '| cat >>~/temp.k1

echo "W pliku words występuje następująca ilość każdego ze znaków:"
echo ""

ile=$(wc -l ~/temp.k1 | cut -d ' ' -f 1)

cat ~/temp.k1

echo ""
echo "Wykres: "
echo ""

for((i=1; i<=ile; i++))
do
znak=$(cat ~/temp.k1 | cut -d ' ' -f 3 | head -${i} | tail -1)
wystapienia=$(cat ~/temp.k1 | cut -d ' ' -f 2 | head -${i} | tail -1)
wystapienia=$(($wystapienia/500))
wykres=" "
	for((j=0; j<=wystapienia; j++))
	do
		wykres+="*"
	done
echo "$znak $wykres"
done

rm ~/temp.k1
