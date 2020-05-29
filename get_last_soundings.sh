#!/bin/sh
### Obtenemos la fecha de hoy 
year=$(date +"%Y")
month=$(date +"%m")
#day=$(date +"%d")
day=14
### Si se quiere obtener una fecha específica se usan las siguientes lineas
#year=2016
#month=2
#day=3
### Corremos curl
echo Descargando el radisondaje de hoy

curl -s 'http://weather.uwyo.edu/cgi-bin/sounding?region=samer&TYPE=TEXT%3ALIST&YEAR='${year}'&MONTH='${month}'&FROM='${day}'12&TO='${day}'12&STNM=85586' > Sounding85586_${year}${month}${day}_12UTC.dat

curl -s 'http://weather.uwyo.edu/cgi-bin/sounding?region=samer&TYPE=TEXT%3ALIST&YEAR='${year}'&MONTH='${month}'&FROM='${day}'00&TO='${day}'00&STNM=85586' > Sounding85586_${year}${month}${day}_00UTC.dat

echo Se guardo como: 
echo Sounding85586_${year}${month}${day} a las 00UTC y 12UTC

#Este script se corre en crontab:
#30 10 * * * /bin/bash /Users/nico/Documents/meteodata/data/soundings/get_soundings.sh
# a las 10:30AM de todos los días del año
