#!/bin/sh
# obtenemos por script el kml del pronóstico de http://predict.habhub.org
## Obtenemos la fecha de hoy
year=$(date +"%Y")
month=$(date +"%m")
day=$(date +"%d")
#hora UTC
hour=$(date -u +"%H")
hour=$(($hour+12)) # convierto a UTC 
min_ac=$(date +"%M")
min=$(($min_ac + 5))
#por seguridad se corre en 5 min mdespués
#sec=$(date +"%S")

echo Se corre para el tiempo:
echo ${year}/${month}/${day} ${hour}:${min}
echo ###############################################################

## Lat, Lon y altura
lat=-33.65
lon=-71.61
h=40
## Ballon [m/s],[m]
vel_up=5
vel_down=2
ruptura=30000
#drag=


#Priemer paso, ejecutar el programa:
echo Corremos curl para obtener uuid del pronóstico
curl 'http://predict.habhub.org/ajax.php?action=submitForm' -H 'Cookie: cusf_predictor=%7B%7D' -H 'Origin: http://predict.habhub.org' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: es-ES,es;q=0.9' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: application/json, text/javascript, */*' -H 'Referer: http://predict.habhub.org/' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --data 'launchsite=Other&lat='${lat}'&lon='${lon}'&initial_alt='${h}'&hour='${hour}'&min='${min}'&second=0&day='${day}'&month='${month}'&year='${year}'&ascent='${vel_up}'&burst='${ruptura}'&drag=5&submit=Run+Prediction' --compressed > /home/nico/bash_script/balloon_predict/uuid_ballon.dat

echo El archivo creado es uuid_ballon.dat
#cat /home/pi/run_cambridge/uuid_ballon.dat
cat /home/nico/bash_script/balloon_predict/uuid_ballon.dat
echo '\n'
echo Obtenemos el uuid del archivo
uuid=$(sed 's/.*:"\(.*\)","timestamp.*/\1/' /home/nico/bash_script/balloon_predict/uuid_ballon.dat)
echo uuid = ${uuid} '\n'
#Segundo paso obtenemos el kml:
echo Obtenemos el KML '\n'
sleep 5
curl 'http://predict.habhub.org/kml.php?uuid='${uuid}'' -o /home/nico/bash_script/balloon_predict/Cambridge${year}${month}${day}${hour}${min}.kml

rm /home/nico/bash_script/balloon_predict/*.dat 
