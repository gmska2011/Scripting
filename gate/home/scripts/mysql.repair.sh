[root@Neogate mysql]# export USER=root PASSWORD=uk.rjyfn2009 HOST=mysql
[root@Neogate mysql]# ( mysql -u$USER -p$PASSWORD $HOST -Bse 'show tables;' ) | ( while read tb; do mysql -u$USER -p$PASSWORD $HOST -Bse "repair table $tb"; done )
