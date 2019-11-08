/etc/init.d/nginx stop
/etc/init.d/apache2 stop
./certbot-auto certonly --standalone -d hockey.neo63.ru  
/etc/init.d/nginx start
/etc/init.d/apache2 start
