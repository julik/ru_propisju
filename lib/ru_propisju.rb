# -*- encoding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

require 'bigdecimal'

# Самый лучший, прекрасный, кривой и неотразимый суперпечататель суммы прописью для Ruby.
#
#   RuPropisju.rublej(123) # "сто двадцать три рубля"
module RuPropisju

  VERSION = '2.6.1'

  # http://www.xe.com/symbols.php
  # (лица, приближенные форексам и всяким там валютам и курсам)
  # говорят, что код валюты российского рубля - rub
  CURRENCIES = {
    "rur" => :rublej,
    "rub" => :rublej,
    "usd" => :dollarov,
    "uah" => :griven,
    "eur" => :evro,
    "kzt" => :tenge,
    "kgs" => :som,
    'chf' => :francov,
    'cny' => :yuanej,
    'gbp' => :sterlingov,
    'hkd' => :hk_dollarov,
    'jpy' => :yen,
    'try' => :lir
  }

  SUPPORTED_CURRENCIES = CURRENCIES.keys.join ','

  # Наименования указаны в соответствии с общероссийским классификатором валют
  TRANSLATIONS = {
    'ru' => {
      0 => "",
      '0' => "ноль",
      :thousands => ["тысяча", "тысячи", "тысяч"],
      :millions => ["миллион", "миллиона", "миллионов"],
      :billions => ["миллиард", "миллиарда", "миллиардов"],
      :trillions => ["триллион", "триллиона", "триллионов"],
      100 => "сто",
      200 => "двести",
      300 => "триста",
      400 => "четыреста",
      500 => "пятьсот",
      600 => "шестьсот",
      700 => "семьсот",
      800 => "восемьсот",
      900 => "девятьсот",

      10 => "десять",
      11 => "одиннадцать",
      12 => "двенадцать",
      13 => "тринадцать",
      14 => "четырнадцать",
      15 => "пятнадцать",
      16 => "шестнадцать",
      17 => "семнадцать",
      18 => "восемнадцать",
      19 => "девятнадцать",
      20 => "двадцать",
      30 => "тридцать",
      40 => "сорок",
      50 => "пятьдесят",
      60 => "шестьдесят",
      70 => "семьдесят",
      80 => "восемьдесят",
      90 => "девяносто",
      # единицы, местами - c учетом рода
      1 => {1 => "один", 2 => 'одна', 3 => 'одно'},
      2 => {1 => "два", 2 => 'две', 3 => 'два'},
      3 => "три",
      4 => "четыре",
      5 => "пять",
      6 => "шесть",
      7 => "семь",
      8 => "восемь",
      9 => "девять",
      :rub_integral => ["рубль", "рубля", "рублей"],
      :rub_fraction => ['копейка', 'копейки', 'копеек'],
      :uah_integral => ["гривна", "гривны", "гривен"],
      :uah_fraction => ['копейка', 'копейки', 'копеек'],
      :kzt_integral => ["тенге", "тенге", "тенге"],
      :kzt_fraction => ['тиын', 'тиына', 'тиынов'],
      :kgs_integral => ["сом", "сома", "сомов"],
      :kgs_fraction => ['тыйын', 'тыйына', 'тыйынов'],
      :eur_integral => ["евро", "евро", "евро"],
      # по опыту моей прошлой работы в банке
      # центами называют дробную часть доллара
      # а дробную часть евро называют евроцентом
      :eur_fraction => ["цент", "цента", "центов"],
      :usd_integral => ["доллар", "доллара", "долларов"],
      :usd_fraction => ['цент', 'цента', 'центов'],
      :chf_integral => ['швейцарский франк', 'швейцарских франка', 'швейцарских франков'],
      :chf_fraction => ['сантим', 'сантима', 'сантимов'],
      :cny_integral => ['юань', 'юаня', 'юаней'],
      :cny_fraction => ['фэнь', 'фэня', 'фэней'],
      :gbp_integral => ['фунт стерлингов', 'фунта стерлингов', 'фунтов стерлингов'],
      :gbp_fraction => ['пенс', 'пенса', 'пенсов'],
      :hkd_integral => ['гонконгский доллар', 'гонконгских доллара', 'гонконгских долларов'],
      :hkd_fraction => ["цент", "цента", "центов"],
      :jpy_integral => ['иена', 'иены', 'иен'],
      :jpy_fraction => ['сен', 'сена', 'сенов'],
      :try_integral => ['турецкая лира', 'турецкие лиры', 'турецких лир'],
      :try_fraction => ['куруш', 'куруша', 'курушей']
    },
    'ru_in' => { # Предложный падеж, например в 2 городах
      0 => "",
      '0' => "нуле",
      :thousands => ["тысяче", "тысячах", "тысячах"],
      :millions => ["миллионе", "миллионах", "миллионах"],
      :billions => ["миллиарде", "миллиардах", "миллиардах"],
      :trillions => ["триллионе", "триллионах", "триллионах"],
      100 => "ста",
      200 => "двухстах",
      300 => "трёхстах",
      400 => "четырёхстах",
      500 => "пятистах",
      600 => "шестистах",
      700 => "семистах",
      800 => "восьмистах",
      900 => "девятистах",

      10 => "десяти",
      11 => "одиннадцати",
      12 => "двенадцати",
      13 => "тринадцати",
      14 => "четырнадцати",
      15 => "пятнадцати",
      16 => "шестнадцати",
      17 => "семнадцати",
      18 => "восемнадцати",
      19 => "девятнадцати",
      20 => "двадцати",
      30 => "тридцати",
      40 => "сорока",
      50 => "пятидесяти",
      60 => "шестидесяти",
      70 => "семидесяти",
      80 => "восьмидесяти",
      90 => "девяноста",
      # единицы, местами - c учетом рода
      1 => { 1 => 'одном', 2 => 'одной', 3 => 'одном' },
      2 => { 1 => 'двух', 2 => 'двух', 3 => 'двух' },
      3 => "трёх",
      4 => "четырёх",
      5 => "пяти",
      6 => "шести",
      7 => "семи",
      8 => "восьми",
      9 => "девяти",
      :rub_integral => %w[рубле рублях рублях],
      :rub_fraction => %w[копейке копейках копейках],
      :uah_integral => %w[гривне гривнах гривнах],
      :uah_fraction => %w[копейке копейках копейках],
      :kzt_integral => %w[тенге тенге тенге],
      :kzt_fraction => %w[тиыне тиынах тиынах],
      :kgs_integral => %w[соме сомах сомах],
      :kgs_fraction => %w[тыйыне тыйынах тыйынах],
      :eur_integral => %w[евро евро евро],
      # по опыту моей прошлой работы в банке
      # центами называют дробную часть доллара
      # а дробную часть евро называют евроцентом
      :eur_fraction => %w[центе центах центах],
      :usd_integral => %w[долларе долларах долларах],
      :usd_fraction => %w[центе центах центах],
      :chf_integral => ['швейцарском франке', 'швейцарских франках', 'швейцарских франках'],
      :chf_fraction => %w[сантиме сантимах сантимах],
      :cny_integral => %w[юане юанях юанях],
      :cny_fraction => %w[фэне фэнях фэнях],
      :gbp_integral => ['фунте стерлингов', 'фунтах стерлингов', 'фунтах стерлингов'],
      :gbp_fraction => %w[пенсе пенсах пенсах],
      :hkd_integral => ['гонконгском долларе', 'гонконгских долларах', 'гонконгских долларах'],
      :hkd_fraction => %w[центе центах центах],
      :jpy_integral => %w[иене иен иенах],
      :jpy_fraction => %w[сене сен сенах],
      :try_integral => ['турецкой лире', 'турецких лир', 'турецких лирах'],
      :try_fraction => ['куруше', 'курушах', 'курушах']
    },
    'ru_gen' => { # Родительный падеж, например в течение одного рабочего дня, пяти ночей (нуля рабочих дней)
       0 => '',
       '0' => 'нуля',
       :thousands => %w[тысячи тысяч тысяч],
       :millions => %w[миллиона миллионов миллионов],
       :billions => %w[миллиарда миллиардов миллиардов],
       :trillions => ["триллиона", "триллионах", "триллионах"],
       100 => 'ста',
       200 => 'двухсот',
       300 => 'трёхсот',
       400 => 'четырёхсот',
       500 => 'пятисот',
       600 => 'шестисот',
       700 => 'семисот',
       800 => 'восьмисот',
       900 => 'девятисот',

       10 => 'десяти',
       11 => 'одиннадцати',
       12 => 'двенадцати',
       13 => 'тринадцати',
       14 => 'четырнадцати',
       15 => 'пятнадцати',
       16 => 'шестнадцати',
       17 => 'семнадцати',
       18 => 'восемнадцати',
       19 => 'девятнадцати',
       20 => 'двадцати',
       30 => 'тридцати',
       40 => 'сорока',
       50 => 'пятидесяти',
       60 => 'шестидесяти',
       70 => 'семидесяти',
       80 => 'восьмидесяти',
       90 => 'девяноста',
       # единицы, местами - c учетом рода
       1 => { 1 => 'одного', 2 => 'одной', 3 => 'одного' },
       2 => { 1 => 'двух', 2 => 'двух', 3 => 'двух' },
       3 => 'трёх',
       4 => 'четырёх',
       5 => 'пяти',
       6 => 'шести',
       7 => 'семи',
       8 => 'восьми',
       9 => 'девяти',
       :rub_integral => %w[рубля рублей рублей],
       :rub_fraction => %w[копейки копеек копеек],
       :uah_integral => %w[гривны гривен гривен],
       :uah_fraction => %w[копейки копеек копеек],
       :kzt_integral => %w[тенге тенге тенге],
       :kzt_fraction => %w[тиына тиынов тиынов],
       :kgs_integral => %w[сома сомов сомов],
       :kgs_fraction => %w[тыйына тыйынов тыйынов],
       :eur_integral => %w[евро евро евро],
       # TODO: решить как же всё-таки звать дробную часть евро: "цент" или "евроцент"
       :eur_fraction => %w[цента центов центов],
       :usd_integral => %w[доллара долларов долларов],
       :usd_fraction => %w[цента центов центов],
       :chf_integral => ['швейцарского франка', 'швейцарских франков', 'швейцарских франков'],
       :chf_fraction => %w[сантима сантимов сантимов],
       :cny_integral => %w[юаня юаней юаней],
       :cny_fraction => %w[фэня фэней фэней],
       :gbp_integral => ['фунта стерлингов', 'фунтов стерлингов', 'фунтов стерлингов'],
       :gbp_fraction => %w[пенсе пенсов пенсов],
       :hkd_integral => ['гонконгского доллара', 'гонконгских долларов', 'гонконгских долларов'],
       :hkd_fraction => %w[цента центов центов],
       :jpy_integral => %w[иены иен иен],
       :jpy_fraction => %w[сен сенов сенов],
       :try_integral => ['турецкой лиры', 'турецких лир', 'турецких лир'],
       :try_fraction => ['куруша', 'курушей', 'курушей']
    },
    'ru_from' => {
      0 => "",
      '0' => "нулём",
      :thousands => ["тысячю", "тысячами", "тысячами"],
      :millions => ["миллионом", "миллионами", "миллионами"],
      :billions => ["миллиардом", "миллиардами", "миллиардами"],
      :trillions => ["триллионом", "триллионами", "триллионами"],
      100 => "ста",
      200 => "двумястами",
      300 => "тремястами",
      400 => "четырьмястами",
      500 => "пятьюстами",
      600 => "шестьюстами",
      700 => "семьюстами",
      800 => "восьмьюстами",
      900 => "девятьюстами",

      10 => "десятью",
      11 => "одиннадцатью",
      12 => "двенадцатью",
      13 => "тринадцатью",
      14 => "четырнадцатью",
      15 => "пятнадцатью",
      16 => "шестнадцатью",
      17 => "семнадцатью",
      18 => "восемнадцатью",
      19 => "девятнадцатью",
      20 => "двадцатью",
      30 => "тридцатью",
      40 => "сорока",
      50 => "пятьюдесятью",
      60 => "шестьюдесятью",
      70 => "семьюдесятью",
      80 => "восьмьюдесятью",
      90 => "девяноста",
      # единицы, местами - c учетом рода
      1 => {1 => "одним", 2 => 'одной', 3 => 'одним'},
      2 => {1 => "двумя", 2 => 'двумя', 3 => 'двумя'},
      3 => "тремя",
      4 => "четырьмя",
      5 => "пятью",
      6 => "шестью",
      7 => "семью",
      8 => "восьмью",
      9 => "девятью",
      :rub_integral => ["рублём", "рублями", "рублями"],
      :rub_fraction => ['копейкой', 'копейками', 'копейками'],
      :uah_integral => ["гривной", "гривнами", "гривнами"],
      :uah_fraction => ['копейкой', 'копейками', 'копейками'],
      :kzt_integral => ["тенге", "тенге", "тенге"],
      :kzt_fraction => ['тиыной', 'тиынами', 'тиынами'],
      :kgs_integral => ["сомом", "сомами", "сомами"],
      :kgs_fraction => ['тыйыном', 'тыйынами', 'тыйынами'],
      :eur_integral => ["евро", "евро", "евро"],
      # по опыту моей прошлой работы в банке
      # центами называют дробную часть доллара
      # а дробную часть евро называют евроцентом
      :eur_fraction => ["центом", "центами", "центами"],
      :usd_integral => ["долларом", "долларами", "долларами"],
      :usd_fraction => ['центом', 'центами', 'центами'],
      :chf_integral => ['швейцарским франком', 'швейцарскими франками', 'швейцарскими франками'],
      :chf_fraction => %w[сантимом сантимами сантимами],
      :cny_integral => %w[юанем юанями юанями],
      :cny_fraction => %w[фэнем фэнями фэнями],
      :gbp_integral => ['фунтом стерлингов', 'фунтами стерлингов', 'фунтами стерлингов'],
      :gbp_fraction => %w[пенсом пенсами пенсами],
      :hkd_integral => ['гонконгским долларом', 'гонконгскими долларами', 'гонконгскими долларами'],
      :hkd_fraction => ['центом', 'центами', 'центами'],
      :jpy_integral => %w[иеной иенами иенами],
      :jpy_fraction => %w[сеном сенами сенами],
      :try_integral => ['турецкой лирой', 'турецкими лирами', 'турецкими лирами'],
      :try_fraction => ['курушем', 'курушами', 'курушами']
    },
    'ua' => {
      0 => "",
      '0' => "нуль",
      :thousands => ["тисяча", "тисячі", "тисяч"],
      :millions => ["мільйон", "мільйона", "мільйонів"],
      :billions => ["мільярд", "мільярда", "мільярдів"],
      :trillions => ["трильйон", "трильйона", "трильйонів"],
      100 => "сто",
      200 => "двісті",
      300 => "триста",
      400 => "чотириста",
      500 => "п'ятьсот",
      600 => "шістсот",
      700 => "сімсот",
      800 => "вісімсот",
      900 => "дев'ятсот",

      10 => "десять",
      11 => "одинадцять",
      12 => "дванадцять",
      13 => "тринадцять",
      14 => "чотирнадцять",
      15 => "п'ятнадцять",
      16 => "шістнадцять",
      17 => "сімнадцять",
      18 => "вісімнадцять",
      19 => "дев'ятнадцять",
      20 => "двадцять",
      30 => "тридцять",
      40 => "сорок",
      50 => "п'ятьдесят",
      60 => "шістдесят",
      70 => "сімдесят",
      80 => "вісімдесят",
      90 => "дев'яносто",
      # единицы, местами - c учетом рода
      1 => {1 => "один", 2 => 'одна', 3 => 'одне'},
      2 => {1 => "два", 2 => 'дві', 3 => 'два'},
      3 => "три",
      4 => "чотири",
      5 => "п'ять",
      6 => "шість",
      7 => "сім",
      8 => "вісім",
      9 => "дев'ять",
      :rub_integral => ["рубль", "рубля", "рублів"],
      :rub_fraction => ['копійка', 'копійки', 'копійок'],
      :uah_integral => ["гривня", "гривні", "гривень"],
      :uah_fraction => ["копійка", "копійки", "копійок"],
      :kzt_integral => ["тенге", "тенге", "тенге"],
      :kzt_fraction => ['тиын', 'тиына', 'тиынов'],
      :kgs_integral => ["сом", "сома", "сомов"],
      :kgs_fraction => ['тыйын', 'тыйына', 'тыйынов'],
      :eur_integral => ["євро", "євро", "євро"],
      :eur_fraction => ["євроцент", "євроцента", "євроцентів"],
      :usd_integral => ["долар", "долара", "доларів"],
      :usd_fraction => ['цент', 'цента', 'центів'],
      :chf_integral => ['швейцарський франк', 'швейцарських франки', 'швейцарських франків'],
      :chf_fraction => ['сантим', 'сантими', 'сантимів'],
      :cny_integral => ['юань', 'юані', 'юанів'],
      :cny_fraction => ['фень', 'фені', 'феней'],
      :gbp_integral => ['фунт стерлінгів', 'фунта стерлінгів', 'фунтів стерлінгів'],
      :gbp_fraction => ['пенс', 'пенса', 'пенсів'],
      :hkd_integral => ['гонконгський долар', 'гонконгського долара', 'гонконгських доларів'],
      :hkd_fraction => ["цент", "цента", "центів"],
      :jpy_integral => ['ієна', 'ієни', 'єн'],
      :jpy_fraction => ['сен', 'сіна', 'сінів'],
      :try_integral => ['турецька ліра', 'турецькі ліри', 'турецьких лір'],
      :try_fraction => ['куруш', 'куруша', 'куруш']
    }
  }
  # Переименовал предложный падеж из _in в _pre (prepositional)
  # Оставил 'ru_in' для обратной совместимости
  TRANSLATIONS['ru_pre'] = TRANSLATIONS['ru_in']

  MONEY_GENDERS = {
    :rub => 1,
    :usd => 1,
    :uah => 2,
    :eur => 1,
    :kzt => 1,
    :kgs => 1,
    :chf => 1,
    :cny => 1,
    :gbp => 1,
    :hkd => 1,
    :jpy => 2,
    :try => 2
  }

  FRACTION_GENDERS = {
    :rub => 2,
    :usd => 1,
    :uah => 2,
    :eur => 1,
    :kzt => 1,
    :kgs => 1,
    :chf => 1,
    :cny => 1,
    :gbp => 1,
    :hkd => 1,
    :jpy => 1,
    :try => 1
  }


  # Кидается при запросе неизвестной валюты
  class UnknownCurrency < ArgumentError
  end

  # Кидается при запросе неизвестного языка
  class UnknownLocale < ArgumentError
  end

  # Выбирает нужный падеж существительного в зависимости от числа
  #
  #   choose_plural(3, "штука", "штуки", "штук") #=> "штуки"
  def choose_plural(amount, *variants)
    variants = variants.flatten

    mod_ten = amount % 10
    mod_hundred = amount % 100
    variant = if (mod_ten == 1 && mod_hundred != 11)
        1
    else
      if mod_ten >= 2 && mod_ten <= 4 && (mod_hundred <10 || mod_hundred % 100>=20)
        2
      else
        3
      end
    end
    variants[variant-1]
  end

  # Выводит сумму прописью в зависимости от выбранной валюты.
  # Поддерживаемые валюты: rur, usd, uah, eur
  #
  #   amount_in_words(345.2, 'rur') #=> "триста сорок пять рублей 20 копеек"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  # * +:fraction_formatter+ - строка. формат отображения числа после точки, например '%d'
  def amount_in_words(amount, currency, locale = :ru, options = {})
    currency = currency.to_s.downcase
    unless CURRENCIES.has_key? currency
      raise UnknownCurrency, "Unsupported currency #{currency}, the following are supported: #{SUPPORTED_CURRENCIES}"
    end
    method(CURRENCIES[currency]).call(amount, locale, options)
  end

  # Выводит целое или дробное число как сумму в рублях прописью
  #
  #   rublej(345.2) #=> "триста сорок пять рублей 20 копеек"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  # * +:fraction_formatter+ - строка. формат отображения числа после точки, например '%d'
  # Метод оставлен для обратной совместимости
  def rublej(amount, locale = :ru, options = {})
    integrals_key = :rub_integral
    fractions_key = :rub_fraction
    money_gender = MONEY_GENDERS[:rub]

    money(amount, locale, integrals_key, fractions_key, money_gender, FRACTION_GENDERS[:rub], {fraction_as_number: true}.merge(options))
  end

  # Выводит целое или дробное число как сумму в расширенном формате
  #
  #   rublej_extended_format(345.2) #=> "345 рублей 20 копеек (триста сорок пять рублей 20 копеек)"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  # * +:fraction_formatter+ - строка. формат отображения числа после точки, например '%d'
  # * +:integrals_formatter+ - строка. формат отображения целого числа, например '%d'
  # * +:integrals_delimiter+ - строка. разделитель разрядов для целой части числа, например ' '
  def rublej_extended_format(amount, locale = :ru, options = {})
    "#{digit_rublej(amount, locale, options)} (#{rublej(amount, locale, options)})"
  end

  # Выводит целое или дробное число как сумму в рублях и копейках не прописью
  #
  #   digit_rublej(345.2) #=> "345 рублей 20 копеек"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  # * +:fraction_formatter+ - строка. формат отображения числа после точки, например '%d'
  # * +:integrals_formatter+ - строка. формат отображения целого числа, например '%d'
  # * +:integrals_delimiter+ - строка. разделитель разрядов для целой части числа, например ' '
  def digit_rublej(amount, locale = :ru, options = {})
    integrals_key = :rub_integral
    fractions_key = :rub_fraction
    money_gender = MONEY_GENDERS[:rub]

    money(amount, locale, integrals_key, fractions_key, money_gender, FRACTION_GENDERS[:rub],
          (options).merge({integrals_as_number: true, fraction_as_number: true}))
  end
  # Выбирает корректный вариант числительного в зависимости от рода и числа и оформляет сумму прописью
  #
  #   propisju(243, 1) => "двести сорок три"
  #   propisju(221, 2) => "двести двадцать одна"
  def propisju(amount, gender, locale = :ru)
    if amount.kind_of?(Integer)
      propisju_int(amount, gender, [], locale)
    else # также сработает для Decimal, дробные десятичные числительные в долях поэтому женского рода
      propisju_float(amount, locale)
    end
  end

  # Выводит целое или дробное число как сумму для валюты прописью
  #  dollarov(32.02) #=>  "тридцать два доллара два цента"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  # * +:integrals_as_number+ - true/false. принудительно отображать целую часть числом
  # * +:fraction_as_number+ - true/false.  принудительно отображать дробную часть числом
  CURRENCIES.reject { |k, _v| ['rub', 'rur'].include? k }.each do |key, name|

    define_method(name) do |amount, locale = :ru, options = {}| # or even |*args|
      integrals_key = "#{key}_integral".to_sym
      fractions_key = "#{key}_fraction".to_sym
      money_gender = MONEY_GENDERS[key.to_sym]
      fraction_gender = FRACTION_GENDERS[key.to_sym]

      money(amount, locale, integrals_key, fractions_key, money_gender, fraction_gender, options)
    end
  end

  # Выводит сумму прописью в рублях по количеству копеек
  #
  #  kopeek(343) #=> "три рубля 43 копейки"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  # * +:fraction_formatter+ - строка. формат отображения числа после точки, например '%d'
  def kopeek(amount, locale = :ru, options = {})
    rublej(amount / 100.0, locale, options)
  end

  # Выводит сумму данного существительного прописью и выбирает правильное число и падеж
  #
  #    RuPropisju.propisju_shtuk(21, 3, "колесо", "колеса", "колес") #=> "двадцать одно колесо"
  #    RuPropisju.propisju_shtuk(21, 1, "мужик", "мужика", "мужиков") #=> "двадцать один мужик"
  def propisju_shtuk(items, gender, forms, locale = :ru)
    elements = if (items == items.to_i)
      [propisju(items, gender, locale), choose_plural(items, forms)]
    else
      [propisju(items, gender, locale), forms[1]]
    end

    elements.join(" ")
  end

  def money(amount, locale, integrals_key, fractions_key, money_gender, fraction_gender, options = {})

    options[:integrals_formatter] ||= '%d'
    options[:fraction_formatter] ||= '%d'
    options[:integrals_delimiter] ||= ''
    options[:always_show_fraction] ||= false
    options[:integrals_as_number] ||= false
    options[:fraction_as_number] ||= false

    locale_data = pick_locale(TRANSLATIONS, locale)
    integrals = locale_data[integrals_key]
    fractions = locale_data[fractions_key]

    return zero(locale_data, integrals, fractions, options) if amount.zero?

    parts = []

    unless amount.to_i == 0
      if options[:integrals_as_number]
        parts << format_integral(amount.to_i, options) << choose_plural(amount.to_i, integrals)
      else
        parts << propisju_int(amount.to_i, money_gender, integrals, locale)
      end
    end

    if amount.kind_of?(Float) || amount.kind_of?(BigDecimal)
      remainder = (amount.divmod(1)[1]*100).round
      if remainder == 100
        parts = [propisju_int(amount.to_i + 1, money_gender, integrals, locale)]
        parts << zero_fraction(locale, money_gender, fractions, options) if options[:always_show_fraction]
      else
        if options[:fraction_as_number]
          kop = remainder.to_i
          if (!kop.zero? || options[:always_show_fraction])
            parts << format(options[:fraction_formatter], kop) << choose_plural(kop, fractions)
          end
        else
          parts << propisju_int(remainder.to_i, fraction_gender, fractions, locale)
        end
      end
    else
      parts << zero_fraction(locale, money_gender, fractions, options) if options[:always_show_fraction]
    end

    parts.join(' ')
  end

  private

  def zero(locale_data, integrals, fractions, options)
    integ = options[:integrals_as_number] ? format(options[:integrals_formatter], 0) : locale_data['0']
    frac = options[:fraction_as_number] ? format(options[:fraction_formatter], 0) : locale_data['0']
    parts = [integ , integrals[-1], frac, fractions[-1]]
    parts.join(' ')
  end

  def zero_fraction(locale, money_gender, fractions, options)
    if options[:fraction_as_number]
      [format(options[:fraction_formatter], 0), choose_plural(0, fractions)]
    else
      propisju_int(0, money_gender, fractions, locale)
    end
  end

  # Cоставляет число прописью для чисел до тысячи

  def compose_ordinal(remaining_amount_or_nil, gender, item_forms = [], locale = :ru)

    remaining_amount = remaining_amount_or_nil.to_i

    locale = locale.to_s

    # Ноль чего-то
    # return "ноль %s" % item_forms[3] if remaining_amount_or_nil.zero?

    rest, rest1, chosen_ordinal, ones, tens, hundreds = [nil]*6

    rest = remaining_amount  % 1000
    remaining_amount = remaining_amount / 1000
    if rest.zero?
      # последние три знака нулевые
      return item_forms[2]
    end

    locale_root = pick_locale(TRANSLATIONS, locale)

    # начинаем подсчет с Rest
    # сотни
    hundreds = locale_root[(rest / 100).to_i * 100]

    # десятки
    rest = rest % 100
    rest1 = rest / 10

    # единички
    ones = ""
    tens = locale_root[rest1 == 1 ? rest : rest1 * 10]

    # индекс выбранной формы
    chosen_ordinal = 2
    if rest1 < 1 || rest1 > 1 # единицы
      value = locale_root[rest % 10]
      # если попался хэш, делаем выбор согласно рода
      value = value[gender] if value.kind_of? Hash
      ones = value
      case rest % 10
        when 1 then chosen_ordinal = 0 # индекс формы меняется
        when 2..4 then chosen_ordinal = 1 # индекс формы меняется
      end
    end
    plural = [
      hundreds,
      tens,
      ones,
      item_forms[chosen_ordinal],
    ].compact.reject(&:empty?).join(' ').strip

    return plural
  end

  DECIMALS = {
    'ru' =>{
      :source_words => [
        'целая',
        'десятая',
        'сотая',
        'тысячная',
        'десятитысячная',
        'стотысячная',
        'миллионная',
        'десятимиллионная',
        'стомиллионная',
        'миллиардная',
        'десятимиллиардная',
        'стомиллиардная',
        'триллионная'
      ],
      :prefix => ["ая", 'ых'],
    },
    'ru_in' =>{
      :source_words => [
        'целой',
        'десятой',
        'сотой',
        'тысячной',
        'десятитысячной',
        'стотысячной',
        'миллионной',
        'десятимиллионной',
        'стомиллионной',
        'миллиардной',
        'десятимиллиардной',
        'стомиллиардной',
        'триллионной'
      ],
      :prefix => ["ой", 'ых'],
    },
    'ru_from' =>{
      :source_words => [
        'целой',
        'десятой',
        'сотой',
        'тысячной',
        'десятитысячной',
        'стотысячной',
        'миллионной',
        'десятимиллионной',
        'стомиллионной',
        'миллиардной',
        'десятимиллиардной',
        'стомиллиардной',
        'триллионной'
      ],
      :prefix => ["ой", 'ыми'],
    },
    'ua' => {
      :source_words => [
        'ціла',
        'десята',
        'сота',
        'тисячна',
        'десятитисячна',
        'стотисячна',
        'мільйонна',
        'десятимільйонна',
        'стомільйонна',
        'мільярдна',
        'десятимільярдна',
        'стомільярдна',
        'трильонна'
      ],
      :prefix => ["а", 'их'],
    },
  }
  # Добавляем новый префикс для предложного падежа и новые значения для родительного (совпадающие с предложным)
  DECIMALS['ru_pre'] = DECIMALS['ru_in']
  DECIMALS['ru_gen'] = DECIMALS['ru_in']

  # Выдает сумму прописью с учетом дробной доли. Дробная доля округляется до миллионной, или (если
  # дробная доля оканчивается на нули) до ближайшей доли или точки ( 500 тысячных округляется до 5 десятых, 30.0000 до 30).
  def propisju_float(num, locale = :ru)
    locale_root = pick_locale(DECIMALS, locale)
    source_expression = locale_root[:prefix][0]
    target_prefix = locale_root[:prefix][1]
    words = locale_root[:source_words].map do |e|
      [
        e,
        e.gsub(/#{source_expression}$/, target_prefix),
        e.gsub(/#{source_expression}$/, target_prefix),
      ]
    end.freeze

    # Укорачиваем до триллионной доли
    formatted = num.to_s[/^\d+(\.\d{0,#{words.length}})?/].gsub(/0+$/, '')
    wholes, decimals = formatted.split(".")

    return propisju_int(wholes.to_i, 1, [], locale) if decimals.to_i.zero?

    whole_st = propisju_shtuk(wholes.to_i, 2, words[0], locale)

    rem_st = propisju_shtuk(decimals.to_i, 2, words[decimals.length], locale)
    [whole_st, rem_st].compact.join(" ")
  end

  # Выполняет преобразование числа из цифрого вида в символьное
  #
  #   amount - числительное
  #   gender   = 1 - мужской, = 2 - женский, = 3 - средний
  #   one_item - именительный падеж единственного числа (= 1)
  #   two_items - родительный падеж единственного числа (= 2-4)
  #   five_items - родительный падеж множественного числа ( = 5-10)
  #
  # Примерно так:
  #   propisju(42, 1, ["сволочь", "сволочи", "сволочей"]) # => "сорок две сволочи"
  def propisju_int(amount, gender = 1, item_forms = [], locale = :ru)

    locale_root = pick_locale(TRANSLATIONS, locale)

    # zero!
    if amount.zero?
      return [locale_root['0'], item_forms[-1]].compact.join(' ')
    end

    fractions = [
      [:trillions, 1_000_000_000_000],
      [:billions, 1_000_000_000],
      [:millions, 1_000_000],
      [:thousands, 1_000],
    ]

    parts = fractions.map do | name, multiplier |
      [name, fraction = (amount / multiplier) % 1000]
    end

    if amount / fractions.first.last >= 1000
      raise "Amount is too large" 
    end

    # Единицы обрабатываем отдельно
    ones = amount % 1000

    # Составляем простые тысячные доли
    parts_in_writing = parts.reject do | part |
      part[1].zero?
    end.map do | name, fraction |
      thousandth_gender = (name == :thousands) ? 2 : 1
      compose_ordinal(fraction, thousandth_gender, locale_root[name], locale)
    end

    # И только единицы обрабатываем с переданными параметрами
    parts_in_writing.push(compose_ordinal(ones, gender, item_forms, locale))

    parts_in_writing.compact.join(' ')
  end

  def format_integral(number, options)
    formatted_number = format(options[:integrals_formatter], number)
    delimited_number(formatted_number, options[:integrals_delimiter])
  end

  def delimited_number(number, delimiter)
    return number.to_s if delimiter == ''

    number.to_s.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/) do |digit_to_delimit|
      "#{digit_to_delimit}#{delimiter}"
    end || number.to_s
  end

  def pick_locale(from_hash, locale)
    return from_hash[locale.to_s] if from_hash.has_key?(locale.to_s)
    raise UnknownLocale, "Unknown locale #{locale.inspect}"
  end

  alias_method :rublja, :rublej
  alias_method :rubl, :rublej

  alias_method :kopeika, :kopeek
  alias_method :kopeiki, :kopeek

  alias_method :grivna, :griven
  alias_method :grivny, :griven

  alias_method :dollar, :dollarov
  alias_method :dollary, :dollarov

  public_instance_methods(true).map{|m| module_function(m) }

  module_function :zero, :zero_fraction, :propisju_int, :propisju_float, :compose_ordinal, :pick_locale, :format_integral, :delimited_number
end
