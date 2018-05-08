#!/bin/bash
args=("$@")

#While principal
while [ 1 -eq 1 ];do
	if [ $(($SECONDS%60)) -eq 0 ] && [ $SECONDS -ne 0 ]; then
                echo $SECONDS" seconds";
                echo "--STATS--";
		tim=$(date '+%D %r');
		#echo "[$tim]" >> "log.txt";
		for((j=0;j<$#;j++));do
                        while read -r line; do
                                stat=$(awk -f awk1.awk "ping-"$line".txt");
				echo "[$tim] [$line] "$stat >> "log.txt";
                        done < ${args[j]}
                done
		cat "log.txt";

		sleep 1;
	fi
	if [ $(($SECONDS%10)) -eq 0 ] && [ $(($SECONDS%60)) -ne 0 ] || [ $SECONDS -eq 0 ]; then
		echo $SECONDS" seconds";

		for((i=0;i<$#;i++));do
			while read -r line; do
				echo "ping "$line;
				ping -c 1 $line >> "ping-"$line".txt" &
			done < ${args[i]}
		done
		sleep 1;
	fi
done
