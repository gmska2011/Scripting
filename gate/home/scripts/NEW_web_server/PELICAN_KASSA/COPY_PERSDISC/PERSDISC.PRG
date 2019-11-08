*
* Скидка по времени и по дате
*
Priv N_Return
*
N_Return = 0
*
*
If between(BD_CH2.DATE_TOP,{25.06.2018},{25.06.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '77083284' && Горячие напитки
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{21.06.2018},{21.06.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '75702979' && Вода
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{19.06.2018},{19.06.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '74931760' && Мороженое
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{15.06.2018},{15.06.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '69277488' && Рыба замороженная
           N_Return = -35
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{13.06.2018},{13.06.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '43254404' && Замор.овощи
           N_Return = -35
      case LOCPRICE.COD_GRT = '43103092' && Замор.полуфабрикаты
           N_Return = -35
      case LOCPRICE.COD_GRT = '43465142' && Пельмени
           N_Return = -35
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{09.06.2018},{09.06.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '67913537' && Пиво безалко
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{07.06.2018},{07.06.2018})
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
If between(BD_CH2.DATE_TOP,{05.06.2018},{05.06.2018})
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
If between(BD_CH2.DATE_TOP,{31.05.2018},{31.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '42864436' && Торты и пирожные
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{29.05.2018},{29.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '36967825' && Конфеты весовые
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{25.05.2018},{25.05.2018})
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
If between(BD_CH2.DATE_TOP,{23.05.2018},{23.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '72240550' && Крупы
           N_Return = -30
      case LOCPRICE.COD_GRT = '52839405' && Макароны
           N_Return = -30
      case LOCPRICE.COD_GRT = '55709421' && Продукты быстрого приготовления
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{21.05.2018},{21.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '40504010' && Соки и нектары
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{18.05.2018},{18.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '75491144' && Сыр мягкий
           N_Return = -15
      case LOCPRICE.COD_GRT = '70076355' && Сыр твёрдый
           N_Return = -15
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{16.05.2018},{16.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '41111317' && Консервы мясные
           N_Return = -25
      case LOCPRICE.COD_GRT = '41569984' && Консервы рыбные и морские
           N_Return = -25
      case LOCPRICE.COD_GRT = '41320747' && Консервы плодовощные
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{14.05.2018},{14.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '48599624' && Масло растительное
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{10.05.2018},{10.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '72240550' && Крупы
           N_Return = -30
      case LOCPRICE.COD_GRT = '52839405' && Макароны
           N_Return = -30
      case LOCPRICE.COD_GRT = '55709421' && Продукты быстрого приготовления
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{08.05.2018},{08.05.2018})
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
If between(BD_CH2.DATE_TOP,{04.05.2018},{04.05.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '41111317' && Консервы мясные
           N_Return = -25
      case LOCPRICE.COD_GRT = '41569984' && Консервы рыбные и морские
           N_Return = -25
      case LOCPRICE.COD_GRT = '41320747' && Консервы плодовощные
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{28.04.2018},{28.04.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '68283750' && Вино
           N_Return = -30
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '51288938' && Вино свыше 15%
           N_Return = -30
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '41846209' && Алкоголь ниже 9%
           N_Return = -30
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '71994825' && Коктели
           N_Return = -30
      case LOCPRICE.COD_GRT = '68138409' .and. LOCPRICE.COD_SGRT = '68267890' && Крепкий алкоголь
           N_Return = -30
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{26.04.2018},{26.04.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '77361750' && Колбасные изделия
           N_Return = -20
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{24.04.2018},{24.04.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '43254404' && Замор.овощи
           N_Return = -35
      case LOCPRICE.COD_GRT = '43103092' && Замор.полуфабрикаты
           N_Return = -35
      case LOCPRICE.COD_GRT = '43465142' && Пельмени
           N_Return = -35
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{20.04.2018},{20.04.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '39998519' && Уход
           N_Return = -25
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{18.04.2018},{18.04.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '49127828' && Молоко
           N_Return = -15
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
If between(BD_CH2.DATE_TOP,{16.04.2018},{16.04.2018})
   *
   Do case
      case LOCPRICE.COD_GRT = '75491144' && Сыр мягкий
           N_Return = -15
      case LOCPRICE.COD_GRT = '70076355' && Сыр твёрдый
           N_Return = -15
   Endcase
   *
   If N_Return # 0
      RETURN N_Return
   Endif
Endif
*
*
* Skidka pensioneram
If between(secotime(BD_CH2.TIME_TOP),secotime('07:00:00'),secotime('12:00:00')) .and.;
   between(BD_CH2.DATE_TOP,{01.04.2017},{13.02.2019}) .and.;
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
* Pelicafe -30, Proizvodstvo -20
If !between(secotime(BD_CH2.TIME_TOP),secotime('00:30:00'),secotime('19:00:00'))
   Do case
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '50516496'
           * Выпечка Миндаль
           N_Return = -30
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '63790722'
           * Кафе
           N_Return = -30
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '53062231'
           * Блины
           N_Return = -20
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '46789896'
           * Готовая продукция
           N_Return = -20
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '65627007'
           * Салаты
           N_Return = -20
      case LOCPRICE.COD_GRT = '65576699' .and. LOCPRICE.COD_SGRT = '44701319'
           * Выпечка
           N_Return = -20
   Endcase
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
