#!/bin/bash
args=("$@")
echo "----------ASanchez's IDS-----------";
echo "** Initialized at $(date '+%D %r') **";
target="/var/log/syslog";
smtp_syntax_spotted=0;
echo "Setting target to $target";

#While principal
while [ 1 -eq 1 ];do
	if [ $(($SECONDS%5)) -eq 0 ]; then # every 10 seconds
        prev_smtp_syntax_spotted=$smtp_syntax_spotted;
		time_now=$(date '+%D %r');
		
        smtp_syntax_spotted=$(awk -v date="$(date +"%M" -d "1 minutes ago")" -f smtp_syntax.awk $target); # verify for syntax problems
        if [ $smtp_syntax_spotted -gt $prev_smtp_syntax_spotted ]; then
        	echo "[ $time_now] [SMTP syntax alert] There is a SMTP syntax protocol error, total: $smtp_syntax_spotted ";
        	echo "[ $time_now] [SMTP syntax alert] There is a SMTP syntax protocol error, total: $smtp_syntax_spotted " >> "log.txt";
        fi
        
        smtp_mail_sent=$(awk -v date="$(date +"%M" -d "1 minutes ago")" -f ip_send_attempt.awk $target); # verify for syntax problems
        if [ ${#smtp_mail_sent} -ne 0 ]; then
        	echo "[ $time_now] [Excesive mails sent from ip]: $smtp_mail_sent ";
        	echo "[ $time_now] [Excesive mails sent from ip]: $smtp_mail_sent " >> "log.txt";
        fi
        
	fi
	sleep 4;
done
