#!/bin/bash
echo ""
echo -e "\t\tMENU:"
echo "1. Wyświetl zawartość harmonogramu"
echo "2. Dodaj rekord"
echo "3. Usuń rekord"
echo "4. Modyfikuj rekord"

touch ~/Harmonogram.s4
touch ~/tempHarmonogram.s4

read wybor

ile=$( wc -l ~/Harmonogram.s4 | cut -d ' ' -f 1 )
data=$(cat ~/Harmonogram.s4 | cut -d ',' -f 1 | head -${i} | tail -1)

case $wybor in
	"1")
	echo ""
	echo -e "\t\t\tZawartość harmonogramu"
	echo ""
	touch ~/temp_sed.s4
	echo -e  "DATA,CZAS,OPIS,WAŻNOŚĆ" | cat >>~/tempHarmonogram.s4
	cat ~/Harmonogram.s4>>~/tempHarmonogram.s4
	sed 's/||/| |/g;s/||/| | /g' ~/tempHarmonogram.s4 | column -s"," -t | less -#2 -N -S | cat >>~/temp_sed.s4
	cat  ~/temp_sed.s4 | nl -v 0
	rm ~/temp_sed.s4
	rm ~/tempHarmonogram.s4
	echo ""
	;;
	"2")
	echo ""
	echo "Dodaj rekord"
	echo ""
	echo "Podaj Datę [DD-MM-YYYY]"

	read data

	while [[ ! $data =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
	do
		echo "Podano nieprawidlową datę, podaj ją jeszcze raz"
		read data
	done

	echo ""
	echo "Podaj czas [min]"
	read czas

	while [[ ! $czas =~ ^[1-9][0-9]*$ ]]
        do
                echo "Podano nieprawidlowy czas, podaj jeszcze raz"
                read czas
        done

	echo ""
	echo "Podaj opis (nie wolno stosować znaku ','!!!)"
	read opis
	echo ""
	echo "Podaj ważność"
	read waznosc

	while [[ ! $waznosc =~ ^(([1-9])|(10))$ ]]
        do
                echo "Podano nieprawidlową ważnośc, podaj ją jeszcze raz"
                read waznosc
        done

	echo "$data,$czas,$opis,$waznosc"  | cat >>~/Harmonogram.s4
	;;
	"3")
	echo ""
	echo "Usuń rekord"
	echo ""
	touch ~/temp_Harmonogram.s4
	echo "Podaj nr rekordu który chcesz usunąć"
	read rekord
	if [ $rekord -gt $ile ]
	then
		echo ""
		echo "Dany rekord nie istnieje"
	else
		for ((i=1; i<$rekord; i++))
		do
			data=$(cat ~/Harmonogram.s4 | cut -d ',' -f 1 | head -${i} | tail -1)
			czas=$(cat ~/Harmonogram.s4 | cut -d ',' -f 2 | head -${i} | tail -1)
			opis=$(cat ~/Harmonogram.s4 | cut -d ',' -f 3 | head -${i} | tail -1)
			waznosc=$(cat ~/Harmonogram.s4 | cut -d ',' -f 4 | head -${i} | tail -1)
			echo "${data},${czas},${opis},${waznosc}" | cat >>~/temp_Harmonogram.s4
		done
		jeden=1
		rekord=$(($rekord + $jeden))
		for ((i=$rekord; i<=$ile; i++))
		do
			data=$(cat ~/Harmonogram.s4 | cut -d ',' -f 1 | head -${i} | tail -1)
                        czas=$(cat ~/Harmonogram.s4 | cut -d ',' -f 2 | head -${i} | tail -1)
                        opis=$(cat ~/Harmonogram.s4 | cut -d ',' -f 3 | head -${i} | tail -1)
                        waznosc=$(cat ~/Harmonogram.s4 | cut -d ',' -f 4 | head -${i} | tail -1)
                  	echo "$data,$czas,$opis,$waznosc" | cat >>~/temp_Harmonogram.s4
		done
		rm ~/Harmonogram.s4
		touch ~/Harmonogram.s4
		cat ~/temp_Harmonogram.s4>>~/Harmonogram.s4
		rm ~/temp_Harmonogram.s4
	fi
	;;
	"4")
	echo ""
	echo "Modyfikuj rekord"
	echo ""
	echo "Podaj nr rekordu który ma zostać zmodyfikowany"
	read rekord
	if [ $rekord -gt $ile ]
	then
		echo ""
		echo "Dany rekord nie istnieje"
	else
		for ((i=1; i<=$ile; i++))
               do
			if [ $i == $rekord ]
			then
				echo ""
				echo "Co chcesz zmodyfikować? "
				echo "1. DATA"
				echo "2. CZAS_TRWANIA"
				echo "3. OPIS"
				echo "4. WAŻNOŚĆ"
				read wybor

				case $wybor in
				"1")
					echo ""
					echo "Podaj NOWĄ Datę [DD-MM-YYYY]"
				        read data

				        while [[ ! $data =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
				        do
			                echo "Podano nieprawidlową datę, podaj ją jeszcze raz"
			                read data
				        done

					czas=$(cat ~/Harmonogram.s4 | cut -d ',' -f 2 | head -${i} | tail -1)
	                                opis=$(cat ~/Harmonogram.s4 | cut -d ',' -f 3 | head -${i} | tail -1)
	                                waznosc=$(cat ~/Harmonogram.s4 | cut -d ',' -f 4 | head -${i} | tail -1)
	                                echo "${data},${czas},${opis},${waznosc}" | cat >>~/temp_Harmonogram.s4

				;;
				"2")
					echo ""
					echo "Podaj NOWY czas trwania [min]"
                                       read czas

                                        while [[ ! $czas =~ ^[1-9][0-9]*$ ]]
                                       do
                                        echo "Podano nieprawidłowy czas, podaj go jeszcze raz"
                                        read czas
                                       done

                                        data=$(cat ~/Harmonogram.s4 | cut -d ',' -f 1 | head -${i} | tail -1)
                                        opis=$(cat ~/Harmonogram.s4 | cut -d ',' -f 3 | head -${i} | tail -1)
                                        waznosc=$(cat ~/Harmonogram.s4 | cut -d ',' -f 4 | head -${i} | tail -1)
                                        echo "${data},${czas},${opis},${waznosc}" | cat >>~/temp_Harmonogram.s4

				;;
				"3")
					echo ""
					echo "Podaj NOWY opis (nie wolno stosować znaku ','!!!)"
					read opis
					data=$(cat ~/Harmonogram.s4 | cut -d ',' -f 1 | head -${i} | tail -1)
                                       czas=$(cat ~/Harmonogram.s4 | cut -d ',' -f 2 | head -${i} | tail -1)
                                        waznosc=$(cat ~/Harmonogram.s4 | cut -d ',' -f 4 | head -${i} | tail -1)
                                        echo "${data},${czas},${opis},${waznosc}" | cat >>~/temp_Harmonogram.s4
				;;
				"4")
					echo ""
					echo "Podaj NOWĄ ważność [1-10]"

                                        read waznosc

                                        while [[ ! $waznosc =~ ^(([1-9])|(10))$ ]]
                                       do
					echo ""
                                        echo "Podano nieprawidlową ważność, podaj ją jeszcze raz"
                                        read waznosc
                                        done

                                        data=$(cat ~/Harmonogram.s4 | cut -d ',' -f 1 | head -${i} | tail -1)
                                        czas=$(cat ~/Harmonogram.s4 | cut -d ',' -f 2 | head -${i} | tail -1)
                                        opis=$(cat ~/Harmonogram.s4 | cut -d ',' -f 3 | head -${i} | tail -1)
                                        echo "${data},${czas},${opis},${waznosc}" | cat >>~/temp_Harmonogram.s4

				;;
				*)
					echo ""
					echo "Nieprawidłowa opcja, koniec pracy skryptu!!!"
				;;
				esac
			else
                      		data=$(cat ~/Harmonogram.s4 | cut -d ',' -f 1 | head -${i} | tail -1)
                       		czas=$(cat ~/Harmonogram.s4 | cut -d ',' -f 2 | head -${i} | tail -1)
                        	opis=$(cat ~/Harmonogram.s4 | cut -d ',' -f 3 | head -${i} | tail -1)
                        	waznosc=$(cat ~/Harmonogram.s4 | cut -d ',' -f 4 | head -${i} | tail -1)
                        	echo "${data},${czas},${opis},${waznosc}" | cat >>~/temp_Harmonogram.s4
			fi
                done

	rm ~/Harmonogram.s4
        touch ~/Harmonogram.s4
        cat ~/temp_Harmonogram.s4>>~/Harmonogram.s4
        rm ~/temp_Harmonogram.s4

	fi
	;;
	*)
	echo ""
	echo "Niepoprawna opcja, koniec pracy skryptu!!"
	;;
esac
