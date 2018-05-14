#!/usr/bin/awk -f
BEGIN{
	spotted=0;
}
/smtp_server/{
	split($3, pieces, ":");
	if(pieces[2]-(date-1) >= 1)
		$7=="Syntax"?spotted++:"";
}
END{
	printf spotted;
}
