/etc/init.d/nginx stop
/etc/init.d/apache2 stop
./certbot-auto certonly --standalone -d hockeytlt.xyz -d www.hockeytlt.xyz -d www2.hockeytlt.xyz -d nagios.hockeytlt.xyz -d cloud.hockeytlt.xyz -d hockey.neo63.ru 
/etc/init.d/nginx start
/etc/init.d/apache2 start
