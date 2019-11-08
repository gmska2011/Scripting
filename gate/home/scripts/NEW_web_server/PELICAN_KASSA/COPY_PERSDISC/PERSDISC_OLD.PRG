*
* Скидка по времени для продукции производства Миндаль
*
Priv N_Return, N_Proc, T_Begin, T_End
*
N_Proc  = -30         && Процент скидки по времени
N_Proc2 = -20         && Для "Выпечка Миндаль" и "Кафе"
T_Begin = '00:30:00'  && НЕ Время начала    скидки по времени (24:60:60)
T_End   = '20:00:00'  && НЕ Время окончания скидки по времени (24:60:60)
T_End2  = '19:00:00'  && Для "Выпечка Миндаль" и "Кафе"
*
N_Return = 0
*
If !between(secotime(BD_CH2.TIME_TOP),secotime(T_Begin),secotime(T_End2))
	Do case
		case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '50516496'
		        RETURN N_Proc2    && Выпечка Миндаль
		case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '63790722'
		        RETURN N_Proc2    && Кафе
	Endcase
Endif
*
If between(secotime(BD_CH2.TIME_TOP),secotime(T_Begin),secotime(T_End))
   RETURN N_Return
Endif
*
Do case
*   case LOCPRICE.COD_GRT = '66788863' && Кондитерский цех
*        RETURN N_Proc
*   case LOCPRICE.COD_GRT = '51378079' .and. LOCPRICE.COD_SGRT = '64572544'
*        RETURN N_Proc    && Копчености
*   case LOCPRICE.COD_GRT = '51378079' .and. LOCPRICE.COD_SGRT = '51143839'
*        RETURN N_Proc    && Кулинария
   case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '51437224'
        RETURN N_Proc    && Салаты/выпечка доставка
Endcase
*
RETURN N_Return
