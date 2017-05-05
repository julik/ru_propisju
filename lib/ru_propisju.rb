# -*- encoding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

require 'bigdecimal'

# Самый лучший, прекрасный, кривой и неотразимый суперпечататель суммы прописью для Ruby.
#
#   RuPropisju.rublej(123) # "сто двадцать три рубля"
module RuPropisju

  VERSION = '2.5.1'

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
  }

  SUPPORTED_CURRENCIES = CURRENCIES.keys.join ','

  TRANSLATIONS = {
    'ru' => {
      0 => "",
      '0' => "ноль",
      :thousands => ["тысяча", "тысячи", "тысяч"],
      :millions => ["миллион", "миллиона", "миллионов"],
      :billions => ["миллиард", "миллиарда", "миллиардов"],
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
      :bel_integral => ["белорусский рубль", "белорусских рубля", "белорусских рублей"],
      :rub_fraction => ['копейка', 'копейки', 'копеек'],
      :uah_integral => ["гривна", "гривны", "гривен"],
      :uah_fraction => ['копейка', 'копейки', 'копеек'],
      :kzt_integral => ["тенге", "тенге", "тенге"],
      :kzt_fraction => ['тиын', 'тиына', 'тиынов'],
      :eur_integral => ["евро", "евро", "евро"],
      # по опыту моей прошлой работы в банке
      # центами называют дробную часть доллара
      # а дробную часть евро называют евроцентом
      :eur_fraction => ["цент", "цента", "центов"],
      :usd_integral => ["доллар", "доллара", "долларов"],
      :usd_fraction => ['цент', 'цента', 'центов'],
    },
    'ru_in' => { # Предложный падеж, например в 2 городах
      0 => "",
      '0' => "нуле",
      :thousands => ["тысяче", "тысячах", "тысячах"],
      :millions => ["миллионе", "миллионах", "миллионах"],
      :billions => ["миллиарде", "миллиардах", "миллиардах"],
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
      :eur_integral => %w[евро евро евро],
      # по опыту моей прошлой работы в банке
      # центами называют дробную часть доллара
      # а дробную часть евро называют евроцентом
      :eur_fraction => %w[центе центах центах],
      :usd_integral => %w[долларе долларах долларах],
      :usd_fraction => %w[центе центах центах],
    },
    'ru_gen' => { # Родительный падеж, например в течение одного рабочего дня, пяти ночей (нуля рабочих дней)
       0 => '',
       '0' => 'нуля',
       :thousands => %w[тысячи тысяч тысяч],
       :millions => %w[миллиона миллионов миллионов],
       :billions => %w[миллиарда миллиардов миллиардов],
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
       :eur_integral => %w[евро евро евро],
       # TODO: решить как же всё-таки звать дробную часть евро: "цент" или "евроцент"
       :eur_fraction => %w[цента центов центов],
       :usd_integral => %w[доллара долларов долларов],
       :usd_fraction => %w[цента центов центов],
    },
    'ru_from' => {
      0 => "",
      '0' => "нулём",
      :thousands => ["тысячю", "тысячами", "тысячами"],
      :millions => ["миллионом", "миллионами", "миллионами"],
      :billions => ["миллиардом", "миллиардами", "миллиардами"],
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
      :eur_integral => ["евро", "евро", "евро"],
      # по опыту моей прошлой работы в банке
      # центами называют дробную часть доллара
      # а дробную часть евро называют евроцентом
      :eur_fraction => ["центом", "центами", "центами"],
      :usd_integral => ["долларом", "долларами", "долларами"],
      :usd_fraction => ['центом', 'центами', 'центами'],
    },
    'ua' => {
      0 => "",
      '0' => "нуль",
      :thousands => ["тисяча", "тисячі", "тисяч"],
      :millions => ["мільйон", "мільйона", "мільйонів"],
      :billions => ["мільярд", "мільярда", "мільярдів"],
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
      :eur_integral => ["євро", "євро", "євро"],
      :eur_fraction => ["євроцент", "євроцента", "євроцентів"],
      :usd_integral => ["долар", "долара", "доларів"],
      :usd_fraction => ['цент', 'цента', 'центів'],
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
  def rublej(amount, locale = :ru, options = {})
    integrals_key = :rub_integral
    fractions_key = :rub_fraction
    money_gender = MONEY_GENDERS[:rub]

    money(amount, locale, integrals_key, fractions_key, money_gender, true, false, options)
  end

  def bel_rublej(amount, locale = :ru, options = {})
    integrals_key = :bel_integral
    fractions_key = :rub_fraction
    money_gender = MONEY_GENDERS[:rub]

    money(amount, locale, integrals_key, fractions_key, money_gender, true, false, options)
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

    money(amount, locale, integrals_key, fractions_key, money_gender, true, true, options)
  end
  # Выбирает корректный вариант числительного в зависимости от рода и числа и оформляет сумму прописью
  #
  #   propisju(243, 1) => "двести сорок три"
  #   propisju(221, 2) => "двести двадцать одна"
  def propisju(amount, gender, locale = :ru)
    if amount.is_a?(Integer) || amount.is_a?(Bignum)
      propisju_int(amount, gender, [], locale)
    else # также сработает для Decimal, дробные десятичные числительные в долях поэтому женского рода
      propisju_float(amount, locale)
    end
  end

  # Выводит целое или дробное число как сумму в гривнах прописью
  #
  #  griven(32) #=> "тридцать две гривны"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  def griven(amount, locale = :ru, options = {})
    integrals_key = :uah_integral
    fractions_key = :uah_fraction
    money_gender = MONEY_GENDERS[:uah]

    money(amount, locale, integrals_key, fractions_key, money_gender, false, false, options)
  end

  # Выводит целое или дробное число как сумму в долларах прописью
  #
  #  dollarov(32) #=> "тридцать два доллара"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  def dollarov(amount, locale = :ru, options = {})
    integrals_key = :usd_integral
    fractions_key = :usd_fraction
    money_gender = MONEY_GENDERS[:usd]

    money(amount, locale, integrals_key, fractions_key, money_gender, false, false, options)
  end

  # Выводит целое или дробное число как сумму в евро прописью
  #
  #  evro(32) #=> "тридцать два евро"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  def evro(amount, locale = :ru, options = {})
    integrals_key = :eur_integral
    fractions_key = :eur_fraction
    money_gender = MONEY_GENDERS[:eur]

    money(amount, locale, integrals_key, fractions_key, money_gender, false, false, options)
  end

  # Выводит целое или дробное число как сумму в тенге прописью
  #
  #  tenge(32) #=> "тридцать два тенге"
  #
  # ==== Опции
  # * +:always_show_fraction+ - true/false. позволяет принудительно отображать 0 в качестве дробной части для целого числа
  def tenge(amount, locale = :ru, options = {})
    integrals_key = :kzt_integral
    fractions_key = :kzt_fraction
    money_gender = MONEY_GENDERS[:kzt]

    money(amount, locale, integrals_key, fractions_key, money_gender, false, false, options)
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

  def money(amount, locale, integrals_key, fractions_key, money_gender, fraction_as_number = false, integrals_as_number = false, options = {})

    options[:integrals_formatter] ||= '%d'
    options[:fraction_formatter] ||= '%d'
    options[:integrals_delimiter] ||= ''
    options[:always_show_fraction] ||= false

    locale_data = pick_locale(TRANSLATIONS, locale)
    integrals = locale_data[integrals_key]
    fractions = locale_data[fractions_key]

    return zero(locale_data, integrals, fractions, fraction_as_number, integrals_as_number, options) if amount.zero?

    parts = []

    if amount.to_i != 0 || integrals_key == :bel_integral
      if integrals_as_number
        parts << format_integral(amount.to_i, options) << choose_plural(amount.to_i, integrals)
      else
        parts << propisju_int(amount.to_i, money_gender, integrals, locale)
      end
    end

    if amount.kind_of?(Float) || amount.kind_of?(BigDecimal)
      remainder = (amount.divmod(1)[1]*100).round
      if remainder == 100
        parts = [propisju_int(amount.to_i + 1, money_gender, integrals, locale)]
        parts << zero_fraction(locale, money_gender, fractions, fraction_as_number, options) if options[:always_show_fraction]
      else
        if fraction_as_number
          kop = remainder.to_i
          if (!kop.zero? || options[:always_show_fraction])
            parts << format(options[:fraction_formatter], kop) << choose_plural(kop, fractions)
          end
        else
          parts << propisju_int(remainder.to_i, money_gender, fractions, locale)
        end
      end
    else
      parts << zero_fraction(locale, money_gender, fractions, fraction_as_number, options) if options[:always_show_fraction]
    end

    parts.join(' ')
  end

  private

  def zero(locale_data, integrals, fractions, fraction_as_number, integrals_as_number, options)
    integ = integrals_as_number ? format(options[:integrals_formatter], 0) : locale_data['0']
    frac = fraction_as_number ? format(options[:fraction_formatter], 0) : locale_data['0']
    parts = [integ , integrals[-1], frac, fractions[-1]]
    parts.join(' ')
  end

  def zero_fraction(locale, money_gender, fractions, fraction_as_number, options)
    if fraction_as_number
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
