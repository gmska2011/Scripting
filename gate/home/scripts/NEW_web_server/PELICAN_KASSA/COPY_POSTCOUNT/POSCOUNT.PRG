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
*
If BD_CH2.DATE >= {04.05.2016} .and. BD_CH2.DATE <= {09.10.2016} .and.;
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
