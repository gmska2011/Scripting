*
* Скидка по времени и по дате
*
Priv N_Return
*
N_Return = 0
*
If between(BD_CH2.DATE_TOP,{02.03.2018},{11.03.2018})
   *
   Do case
      case 'БХ Наб' $ LOCPRICE.NAME
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{27.03.2018},{27.03.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '52573764' && Корма
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{07.02.2018},{07.02.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '37647569' && Соусы
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{09.02.2018},{09.02.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '52573764' && Корма
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{12.02.2018},{12.02.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '61218689' && Конфеты в коробках
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{14.02.2018},{14.02.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '68283750' && Вино
           N_Return = -35
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '51288938' && Вино свыше 15%
           N_Return = -35
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{19.02.2018},{19.02.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '54797424' && Напитки
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{21.02.2018},{21.02.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '77361750' && Колбасные изделия
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{26.02.2018},{26.02.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '37726227' && Уход
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(secotime(BD_CH2.TIME_TOP),secotime('07:00:00'),secotime('12:00:00')) .and.;
   between(BD_CH2.DATE_TOP,{01.04.2017},{30.04.2018}) .and.;
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
* Pekarnya -20%
If !between(secotime(BD_CH2.TIME_TOP),secotime('00:30:00'),secotime('19:00:00')) .and.;
   BD_CH2.DATE_TOP >= {16.01.2018}
   *
   Do case
      * Продукты производства -> Выпечка
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '44701319'
           N_Return = -20
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
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
     (BD_CH2.DATE >= {13.05.2017} .and. BD_CH2.DATE <= {21.08.2017}) .and.;
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
