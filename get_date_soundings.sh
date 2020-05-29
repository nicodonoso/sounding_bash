#!/bin/sh
### Obtenemos la fecha de hoy
#year=$(date +"%Y")
#month=$(date +"%m")
#day=$(date +"%d")

year=2014
month=10
for i in 5 6 7 8 9 10 11
do
	day=$i
### Corremos curl
	echo Descargando el radisondaje de hoy

	curl -s 'http://weather.uwyo.edu/cgi-bin/sounding?region=samer&TYPE=TEXT%3ALIST&YEAR='${year}'&MONTH='${month}'&FROM='${day}'12&TO='${day}'12&STNM=85586' > Sounding85586_${year}${month}${day}_12UTC.dat
	#curl -s 'http://weather.uwyo.edu/cgi-bin/sounding?region=samer&TYPE=TEXT%3ALIST&YEAR='${year}'&MONTH='${month}'&FROM='${day}'00&TO='${day}'00&STNM=85586' > Sounding85586_${year}${month}${day}_00UTC.dat

	echo Se guardo como:
	echo Sounding85586_${year}${month}${day} a las 00UTC y 12UTC
	sed -i '1,10d' "" Sounding85586_${year}${month}${day}_12UTC.dat
done

