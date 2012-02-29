# -*- encoding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

# Самый лучший, прекрасный, кривой и неотразимый суперпечататель суммы прописью для Ruby.
#
#   RuPropisju.rublej(123) # "сто двадцать три рубля"
module RuPropisju

  VERSION = '2.1.1'
  
  # http://www.xe.com/symbols.php
  # (лица, приближенные форексам и всяким там валютам и курсам)
  # говорят, что код валюты российского рубля - rub
  CURRENCIES = {
    "rur" => :rublej,
    "rub" => :rublej,
    "usd" => :dollarov,
    "uah" => :griven,
    "eur" => :evro,
  }
  SUPPORTED_CURRENCIES = CURRENCIES.keys.join ','
  
  TRANSLATIONS = {
    "ru" => {
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
      :rub_fraction => ['копейка', 'копейки', 'копеек'],
      :uah_integral => ["гривна", "гривны", "гривен"],
      :uah_fraction => ['копейка', 'копейки', 'копеек'],
      :eur_integral => ["евро", "евро", "евро"],
      # по опыту моей прошлой работы в банке
      # центами называют дробную часть доллара
      # а дробную часть евро называют евроцентом
      :eur_fraction => ["цент", "цента", "центов"],
      :usd_integral => ["доллар", "доллара", "долларов"],
      :usd_fraction => ['цент', 'цента', 'центов'],
    },
    "ua" => {
      0 => "",
      '0' => "нуль",
      :thousands => ["тисяча", "тисячі", "тисяч"],
      :millions => ["мільйон", "мільйона", "мільйонів"],
      :billions => ["мільярд", "мільярда", "мільярдів"],
      100 => "сто",
      200 => "двісті",
      300 => "триста",
      400 => "чотиреста",
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
      :eur_integral => ["євро", "євро", "євро"],
      :eur_fraction => ["євроцент", "євроцента", "євроцентів"],
      :usd_integral => ["долар", "долара", "доларів"],
      :usd_fraction => ['цент', 'цента', 'центів'],
    }
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
  def amount_in_words(amount, currency, locale = :ru)
    currency = currency.to_s.downcase
    unless CURRENCIES.has_key? currency
      raise UnknownCurrency, "Unsupported currency #{currency}, the following are supported: #{SUPPORTED_CURRENCIES}"
    end
    method(CURRENCIES[currency]).call(amount, locale)
  end

  # Выводит целое или дробное число как сумму в рублях прописью
  #
  #   rublej(345.2) #=> "триста сорок пять рублей 20 копеек"
  def rublej(amount, locale = :ru)
    parts = []
    locale_data = pick_locale(TRANSLATIONS, locale)
    
    integrals = locale_data[:rub_integral]
    fractions = locale_data[:rub_fraction]
    
    parts << propisju_int(amount.to_i, 1, integrals, locale) unless amount.to_i == 0
    if amount.kind_of?(Float)
      remainder = (amount.divmod(1)[1]*100).round
      if (remainder == 100)
        parts = [propisju_int(amount.to_i + 1, 1, integrals, locale)]
      else
        kop = remainder.to_i
        unless kop.zero?
          parts << kop << choose_plural(kop, fractions)
        end
      end
    end
    
    parts.join(' ')
  end

  # Выбирает корректный вариант числительного в зависимости от рода и числа и оформляет сумму прописью
  #
  #   propisju(243) => "двести сорок три"
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
  def griven(amount, locale = 'ru')
    locale_root = pick_locale(TRANSLATIONS, locale)
    
    integrals = locale_root[:uah_integral]
    fractions = locale_root[:uah_fraction]

    parts = []
    parts << propisju_int(amount.to_i, 2, integrals, locale) unless amount.to_i == 0
    if amount.kind_of? Float
      remainder = (amount.divmod(1)[1]*100).round
      if remainder == 100
        parts = [propisju_int(amount.to_i + 1, 2, integrals, locale)]
      else
        parts << propisju_int(remainder.to_i, 2, fractions, locale)
      end
    end
    parts.join(' ')
  end

  # Выводит целое или дробное число как сумму в долларах прописью
  #
  #  dollarov(32) #=> "тридцать два доллара"
  def dollarov(amount, locale = 'ru')
    parts = []
    locale_root = pick_locale(TRANSLATIONS, locale)
    
    integrals = locale_root[:usd_integral]
    fractions = locale_root[:usd_fraction]

    parts << propisju_int(amount.to_i, 1, integrals, locale) unless amount.to_i == 0
    if amount.kind_of?(Float)
      remainder = (amount.divmod(1)[1]*100).round
      if (remainder == 100)
        parts = [propisju_int(amount.to_i + 1, 1, integrals, locale)]
      else
        parts << propisju_int(remainder.to_i, 1, fractions, locale)
      end
    end

    parts.join(' ')
  end

  # Выводит целое или дробное число как сумму в евро прописью
  #
  #  evro(32) #=> "тридцать два евро"
  def evro(amount, locale = 'ru')
    parts = []
    locale_data = pick_locale(TRANSLATIONS, locale)
    
    integrals = locale_data[:eur_integral]
    fractions = locale_data[:eur_fraction]

    parts << propisju_int(amount.to_i, 1, integrals, locale) unless amount.to_i == 0
    if amount.kind_of?(Float)
      remainder = (amount.divmod(1)[1]*100).round
      if (remainder == 100)
        parts = [propisju_int(amount.to_i + 1, 1, integrals, locale)]
      else
        parts << propisju_int(remainder.to_i, 1, fractions, locale)
      end
    end

    parts.join(' ')
  end

  # Выводит сумму прописью в рублях по количеству копеек
  #
  #  kopeek(343) #=> "три рубля 43 копейки"
  def kopeek(amount, locale = :ru)
    rublej(amount / 100.0, locale)
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

  private

  # ранее интерфейс был похож на интерфейс внешний (one_item, two_items, five_items),
  # однако списковая форма строк выглядит предпочтительнее, поэтому интерфейс изменен.
  # по хорошему надо менять также внешний интерфейс, но это может сломать совместимость
  def compose_ordinal(into, remaining_amount, gender, item_forms = [], locale = :ru)
    
    locale = locale.to_s
    
    rest, rest1, chosen_ordinal, ones, tens, hundreds = [nil]*6
    
    rest = remaining_amount % 1000
    remaining_amount = remaining_amount / 1000
    if rest.zero?
      # последние три знака нулевые
      into = item_forms[2] if into.empty?
      return [into, remaining_amount]
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
      into
    ].compact.reject(&:empty?).join(' ').strip
    
    return [plural, remaining_amount]
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


#   DECIMALS = %w( целая десятая сотая тысячная десятитысячная стотысячная
#       миллионная десятимиллионная стомиллионная миллиардная десятимиллиардная
#       стомиллиардная триллионная
#   ).map{|e| [e, e.gsub(/ая$/, "ых"), e.gsub(/ая$/, "ых"), ] }.freeze
#

  # Выдает сумму прописью с учетом дробной доли. Дробная доля округляется до миллионной, или (если
  # дробная доля оканчивается на нули) до ближайшей доли ( 500 тысячных округляется до 5 десятых).
  # Дополнительный аргумент - род существительного (1 - мужской, 2- женский, 3-средний)
  def propisju_float(num, locale = 'ru')
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
    formatted = ("%0.#{words.length}f" % num).gsub(/0+$/, '')
    wholes, decimals = formatted.split(/\./)

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
  #   propisju(42, 1, "сволочь", "сволочи", "сволочей") # => "сорок две сволочи"
  def propisju_int(amount, gender = 1, item_forms = [], locale = :ru)

    locale_root = pick_locale(TRANSLATIONS, locale)

    return locale_root['0'] + ' ' + item_forms[2] if amount.zero?

    # единицы
    into, remaining_amount = compose_ordinal('', amount, gender, item_forms, locale)
    
    return into if remaining_amount.zero?

    [:thousands, :millions, :billions].each do |elem|
      into, remaining_amount = compose_ordinal(
        into,
        remaining_amount,
        gender = (elem == :thousands ? 2 : 1), # пол женский только для тысяч
        locale_root[elem],
        locale
      )
      return into if remaining_amount.zero?
    end

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

  module_function :propisju_int, :propisju_float, :compose_ordinal, :pick_locale
end
