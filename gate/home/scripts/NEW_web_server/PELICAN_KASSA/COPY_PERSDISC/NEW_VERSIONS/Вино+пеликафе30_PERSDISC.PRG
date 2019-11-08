*
* Скидка по времени для продукции производства Миндаль
*
Priv N_Return
*
N_Return = 0
*
* Vino
If between(BD_CH2.DATE_TOP,{14.08.2017},{20.08.2017})
   *
   Do case
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '68283750'
           * vino
           N_Return = -33
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '51288938'
           * vino15
           N_Return = -33
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '41846209'
           * alko9
           N_Return = -33
   Endcase
   *
   If N_Return # 0
      If between(val(LOCPRICE.COD_VVP),440,443) .or.;
         between(val(LOCPRICE.COD_VVP),450,453)
         *
         If LOCPRICE.CENA_ROZN1*(N_Return/100+1) < 164000
            N_Return = int((164000-LOCPRICE.CENA_ROZN1)*100/LOCPRICE.CENA_ROZN1)
         Endif
      Endif
      *
      RETURN N_Return
   Endif
Endif
*
* Water akciya
If between(BD_CH2.DATE_TOP,{07.08.2017},{13.08.2017})
   *
   Do case
      case LOCPRICE.COD_GRT = '54797424'
           * napitki
	   N_Return = -25
           RETURN N_Return
      case LOCPRICE.COD_GRT = '75702979'
           * water
	   N_Return = -25
	   RETURN N_Return
      case LOCPRICE.COD_GRT = '40504010'
           * soki
	   N_Return = -25
	   RETURN N_Return
   Endcase
Endif
*
If between(secotime(BD_CH2.TIME_TOP),secotime('07:00:00'),secotime('12:00:00')) .and.;
   between(BD_CH2.DATE_TOP,{01.04.2017},{31.12.2017}) .and.;
   "Пенсионер" $ BD_CH2.FACE
   *
   Do case
      case LOCPRICE.COD_GRT = '47207836'
           * Табачные изделия - игнорируем
      case LOCPRICE.COD_GRT = '68138409'
           * Алкоголь - игнорируем
      case DOW(BD_CH2.DATE_TOP) = 2
           * Понедельник
           N_Return = -11
      other
           N_Return = -6
   Endcase
Endif
*
* Pelicafe -30
If !between(secotime(BD_CH2.TIME_TOP),secotime('00:30:00'),secotime('19:00:00'))
   Do case
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '50516496'
           * Выпечка Миндаль
           N_Return = -30
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '63790722'
           * Кафе
           N_Return = -30
   Endcase
Endif
*
If   !between(secotime(BD_CH2.TIME_TOP),secotime('00:30:00'),secotime('19:00:00')) .and.;
     (BD_CH2.DATE >= {13.05.2017} .and. BD_CH2.DATE <= {01.01.2018}) .and.;
     (dow(DATE())=7 .or. dow(DATE())=1) .and.;
     (LOCPRICE.COD_TOV = '61209261' .or.;
      LOCPRICE.COD_TOV = '61420335' .or.;
      LOCPRICE.COD_TOV = '61482971' .or.;
      LOCPRICE.COD_TOV = '41194545' .or.;
      LOCPRICE.COD_TOV = '61135445' .or.;
      LOCPRICE.COD_TOV = '61376402' .or.;
      LOCPRICE.COD_TOV = '45105917' .or.;
      LOCPRICE.COD_TOV = '72235849' .or.;
      LOCPRICE.COD_TOV = '60475701' .or.;
      LOCPRICE.COD_TOV = '53569226' .or.;
      LOCPRICE.COD_TOV = '61521274' .or.;
      LOCPRICE.COD_TOV = '67694951' .or.;
      LOCPRICE.COD_TOV = '38039394' .or.;
      LOCPRICE.COD_TOV = '51930464' .or.;
      LOCPRICE.COD_TOV = '67365811' .or.;
      LOCPRICE.COD_TOV = '62518389' .or.;
      LOCPRICE.COD_TOV = '52023154' .or.;
      LOCPRICE.COD_TOV = '69633834' .or.;
      LOCPRICE.COD_TOV = '64968655' .or.;
      LOCPRICE.COD_TOV = '73968420' .or.;
      LOCPRICE.COD_TOV = '73863491' .or.;
      LOCPRICE.COD_TOV = '68390908' .or.;
      LOCPRICE.COD_TOV = '62525503' .or.;
      LOCPRICE.COD_TOV = '74043921' .or.;
      LOCPRICE.COD_TOV = '68691168' .or.;
      LOCPRICE.COD_TOV = '42014525' .or.;
      LOCPRICE.COD_TOV = '63136757' .or.;
      LOCPRICE.COD_TOV = '62887212' .or.;
      LOCPRICE.COD_TOV = '63090202' .or.;
      LOCPRICE.COD_TOV = '63299123' .or.;
      LOCPRICE.COD_TOV = '64220421')
      *
      N_Return = 0
Endif
*
* Skidka -30 salati Mindal
If !between(secotime(BD_CH2.TIME_TOP),secotime('00:30:00'),secotime('20:00:00'))
   Do case
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '51437224'
           * Салаты/выпечка доставка
           N_Return = -30
   Endcase
Endif
*
RETURN N_Return
