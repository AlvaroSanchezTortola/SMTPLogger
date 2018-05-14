#!/usr/bin/awk -f
BEGIN{

}
/smtp_server/{
	split($3, pieces, ":");
	if(pieces[2]-(date-1) >= 1)
		$9=="succesfully"?ip[$11]+=1:"";
}
END{
	for (i in ip){ 
		if	(ip[i]>4)
			print i"  "ip[i];
	}
}
