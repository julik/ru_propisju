Выводит сумму прописью для рублей, гривен и сомов. Помогает в выборе правильного числительного
в зависимости от рода существительного.


    RuPropisju.rublej(123.78) #=> "сто двадцать три рубля 78 копеек"
    RuPropisju.propisju_shtuk(212.40, 2, ["сволочь", "сволочи", "сволочей"]) #=> "двести двенадцать целых четыре десятых сволочи"
    RuPropisju.rublej_extended_format(1000, :ru, 
      fraction_formatter: '%02d',
      integrals_formatter: '+ %d',
      integrals_delimiter: ' ',
      always_show_fraction: true) #=> "+ 1 000 рублей 00 копеек (одна тысяча рублей 00 копеек)"

    cities = RuPropisju.propisju_shtuk(147, 1, ["городе", "городах", "городах"], :ru_in)
    'Продается в %s' % cities #=> "Продается в ста сорока семи городах"

## Установка

Добавьте в `Gemfile`

    gem 'ru_propisju`

и сделайте `bundle install`

## Лицензия

Библиотека поставляется с лицензией MIT, с лицензией можно ознакомиться в файле [LICENSE.txt](LICENSE.txt)
Английский текст лицензии является официальным.