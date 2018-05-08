#!/usr/bin/awk -f
BEGIN{
	transmitted=0;
	received=0;
}
/transmitted/{
	$1==1?transmitted++:"";
	$4==1?received++:"";
}
END{
	percent=received/transmitted;
	percent=percent*100;
	percent=100-percent;
	printf transmitted" packets transmitted, "received" received, "percent"% packet loss.\n";
}
