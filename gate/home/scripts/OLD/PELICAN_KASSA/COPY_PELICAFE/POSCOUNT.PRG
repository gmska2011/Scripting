Para P_Cod, N_Para
*
* Skidka na BLIN`s
*
*  1.   61209261 * vetchina
*  2.   61420335 * kuriza
*  3.   61482971 * myaso
*  4.   41194545 * ananas
*  5.   61135445 * sgushenka
*  6.   61376402 * vishnya
*  7.   45105917 * klubnika
*  8.   72235849 * malina
*  9.   60475701 * persik
*  10.  53569226 * tvorog & izum
*  11.  61521274 * tvorog
*  12.  64220421 * smorodina
*  13.  67694951 * gorbusha
*  14.  38039394 * keta
*  15.  51930464 * fahitos
*  16.  67365811 * fahitos&sous
*  17.  62518389 * gorbusha&sous
*  18.  52023154 * kartofel&gribi&sous
*  19.  69633834 * kartofel&gribi
*  20.  64968655 * keta&sous
*  21.  73968420 * kurica&cir&sous
*  22.  73863491 * kurica&cir
*  23.  68390908 * kurica&sous
*  24.  62525503 * myaso&ris
*  25.  74043921 * myaso&ris&sous
*  26.  68691168 * pikantnaya
*  27.  42014525 * sosiska
*  28.  63136757 * tvorog&sgushenka
*  29.  62887212 * tvorog&jem
*  30.  63090202 * tvorog&izum&jem
*  31.  63299123 * tvorog&izum&sgushenka
*
If BD_CH2.DATE >= {13.05.2016} .and. BD_CH2.DATE <= {11.06.2017} .and.;
   (dow(DATE())=7 .or. dow(DATE())=1) .and.;
   (P_Cod = '61209261' .or.;
    P_Cod = '61420335' .or.;
    P_Cod = '61482971' .or.;
    P_Cod = '41194545' .or.;
    P_Cod = '61135445' .or.;
    P_Cod = '61376402' .or.;
    P_Cod = '45105917' .or.;
    P_Cod = '72235849' .or.;
    P_Cod = '60475701' .or.;
    P_Cod = '53569226' .or.;
    P_Cod = '61521274' .or.;
    P_Cod = '67694951' .or.;
    P_Cod = '38039394' .or.;
    P_Cod = '51930464' .or.;
    P_Cod = '67365811' .or.;
    P_Cod = '62518389' .or.;
    P_Cod = '52023154' .or.;
    P_Cod = '69633834' .or.;
    P_Cod = '64968655' .or.;
    P_Cod = '73968420' .or.;
    P_Cod = '73863491' .or.;
    P_Cod = '68390908' .or.;
    P_Cod = '62525503' .or.;
    P_Cod = '74043921' .or.;
    P_Cod = '68691168' .or.;
    P_Cod = '42014525' .or.;
    P_Cod = '63136757' .or.;
    P_Cod = '62887212' .or.;
    P_Cod = '63090202' .or.;
    P_Cod = '63299123' .or.;
    P_Cod = '64220421')
   *
   If N_Para = 1
      RETURN 3
   Else
      RETURN 1  && Номер группы, идет по нарастающей
   Endif
Endif
*
RETURN 0
