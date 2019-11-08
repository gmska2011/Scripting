Do case
        * Алкоголь
   case LOCPRICE.COD_GRT = '68138409'
   
   other
        RETURN .F.
Endcase
*
* Воскресенье
If  dow(DATE())=1 .and. (secotime(time()) > secotime('16:00:00') .or. secotime(time()) < secotime('09:00:00')) .and.;
    (LOCPRICE.COD_SGRT # '47468488' .and. LOCPRICE.COD_SGRT # '56497410' .and.  LOCPRICE.COD_SGRT # '41846209')
  
   *
     RETURN .T.
Endif

*
If DATE() >= {01.01.2013} .and.;
   (secotime(time()) > secotime('21:00:00') .or.;
    secotime(time()) < secotime('09:00:00'))
   *
   RETURN .T.
Endif
*
nDay=day(DATE())
nMonth=month(DATE())
Do case
   case nMonth = 1 .AND. nDay= 25
        RETURN .T.
   case nMonth = 6 .AND. nDay=1
        RETURN .T.
   case nMonth = 6 .AND. nDay = 27
        RETURN .T.
   case nMonth = 9 .AND. nDay = 1
        RETURN .T.
   case nMonth = 11 .AND. nDay = 17
        RETURN .T.
   case DATE() = {20.06.2015}
        RETURN .T.
Endcase
*
RETURN .F.
