# -*- encoding: utf-8 -*- 
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

module RuPropisju
  VERSION = '1.0.0'
  
  # Выбирает нужный падеж существительного в зависимости от числа
  #
  #   choose_plural(3, "штука", "штуки", "штук") #=> "штуки"
  def choose_plural(amount, *variants)
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
  
  def propisju_items(amount, gender=1, *forms)
    propisju(gender) + " " + choose_plural(amount.to_i, *forms)
  end
  
  # Выводит целое или дробное число как сумму в рублях прописью
  def rublej(amount)
    pts = []
    
    pts << sum_string(amount.to_i, 1, "рубль", "рубля", "рублей") unless amount.to_i == 0
    if amount.kind_of?(Float)
      remainder = (amount.divmod(1)[1]*100).round
      if (remainder == 100)
        pts = [sum_string(amount.to_i+1, 1, 'рубль', 'рубля', 'рублей')]
      else
        pts << sum_string(remainder.to_i, 2, 'копейка', 'копейки', 'копеек')
      end
    end
    
    pts.join(' ')
  end
  
  # Самое мясо
  def propisju(amount, gender = 1)
    if amount === Integer || amount === Bignum
      propisju_int(amount, gender)
    else # также сработает для Decimal
      propisju_float(amount, gender)
    end
  end
  
  # Выводит целое или дробное число как сумму в гривнах прописью
  def griven(amount)
    pts = []

    pts << sum_string(amount.to_i, 2, "гривна", "гривны", "гривен") unless amount.to_i == 0
    if amount.kind_of?(Float)
      remainder = (amount.divmod(1)[1]*100).round
      if (remainder == 100)
        pts = [sum_string(amount.to_i+1, 2, 'гривна', 'гривны', 'гривен')]
      else
        pts << sum_string(remainder.to_i, 2, 'копейка', 'копейки', 'копеек')
      end
    end
    
    pts.join(' ')
  end
  
  def kopeek(amount)
    pts = []
    amount_round = amount.to_i
    r, k = (amount_round / 100.0).floor, (amount_round - ((amount_round / 100.0).floor * 100)).to_i
    pts << sum_string(r, 1, "рубль", "рубля", "рублей") unless r.zero?
    pts << sum_string(k, 2, 'копейка', 'копейки', 'копеек') unless k.zero?
    pts.join(' ')
  end

  #  Выполняет преобразование числа из цифрого вида в символьное
  #   amount - числительное
  #   gender   = 1 - мужской, = 2 - женский, = 3 - средний
  #   one_item - именительный падеж единственного числа (= 1)
  #   two_items - родительный падеж единственного числа (= 2-4)
  #   five_items - родительный падеж множественного числа ( = 5-10)
  # 
  # Примерно так:
  #   propisju(42, 1, "сволочь", "сволочи", "сволочей") # => "сорок две сволочи"
  def sum_string(amount, gender = 1, one_item = '', two_items = '', five_items = '')
    into = ''
    tmp_val = amount
    
    return "ноль " + five_items if amount == 0
    
    # единицы
    into, tmp_val = sum_string_fn(into, tmp_val, gender, one_item, two_items, five_items)

    return into if tmp_val == 0

    # тысячи
    into, tmp_val = sum_string_fn(into, tmp_val, 2, "тысяча", "тысячи", "тысяч") 

    return into if tmp_val == 0

    # миллионы
    into, tmp_val = sum_string_fn(into, tmp_val, 1, "миллион", "миллиона", "миллионов")

    return into if tmp_val == 0

    # миллиарды
    into, tmp_val = sum_string_fn(into, tmp_val, 1, "миллиард", "миллиарда", "миллиардов")
    return into
  end
  
  private
  
  def self.sum_string_fn(into, tmp_val, gender, one_item='', two_items='', five_items='')
    rest, rest1, end_word, ones, tens, hundreds = [nil]*6
    #
    rest = tmp_val % 1000
    tmp_val = tmp_val / 1000
    if rest == 0 
      # последние три знака нулевые 
      into = five_items + " " if into == ""
      return [into, tmp_val]
    end
    #
    # начинаем подсчет с Rest
    end_word = five_items
    # сотни
    hundreds = case rest / 100
      when 0 then ""
      when 1 then "сто "
      when 2 then "двести "
      when 3 then "триста "
      when 4 then "четыреста "
      when 5 then "пятьсот "
      when 6 then "шестьсот "
      when 7 then "семьсот "
      when 8 then "восемьсот "
      when 9 then "девятьсот "
    end

    # десятки
    rest = rest % 100
    rest1 = rest / 10
    ones = ""
    tens = case rest1
      when 0 then ""
      when 1 # особый случай
        case rest
          when 10 then "десять "
          when 11 then "одиннадцать "
          when 12 then "двенадцать "
          when 13 then "тринадцать "
          when 14 then "четырнадцать "
          when 15 then "пятнадцать "
          when 16 then "шестнадцать "
          when 17 then "семнадцать "
          when 18 then "восемнадцать "
          when 19 then "девятнадцать "
        end
      when 2 then "двадцать "
      when 3 then "тридцать "
      when 4 then "сорок "
      when 5 then "пятьдесят "
      when 6 then "шестьдесят "
      when 7 then "семьдесят "
      when 8 then "восемьдесят "
      when 9 then "девяносто "
    end
    #
    if rest1 < 1 or rest1 > 1 # единицы
      case rest % 10
        when 1
          ones = case gender
            when 1 then "один "
            when 2 then "одна "
            when 3 then "одно "
          end
          end_word = one_item
        when 2
          if gender == 2
            ones = "две "
          else
            ones = "два " 
          end       
          end_word = two_items
        when 3
          ones = "три " if end_word = two_items # TODO - WTF?
        when 4
          ones = "четыре " if end_word = two_items  # TODO - WTF?
        when 5
          ones = "пять "
        when 6
          ones = "шесть "
        when 7
          ones = "семь "
        when 8
          ones = "восемь "
        when 9
          ones = "девять "
      end
    end
    
    plural = [hundreds, tens, ones, end_word,  " ",  into].join.strip 
    return [plural, tmp_val] 
  end
  
  # Выдает сумму прописью с учетом дробной доли. Дробная доля округляется до миллионной, или (если
  # дробная доля оканчивается на нули) до ближайшей доли ( 500 тысячных округляется до 5 десятых).
  # Дополнительный аргумент - род существительного (1 - мужской, 2- женский, 3-средний)
  def propisju_float(num, gender = 2)
    raise "Это не число!" if num.respond_to?(:nan) && nan.nan?
    
    st = sum_string(num.to_i, gender, "целая", "целых", "целых")
    
    remainder = num.to_s.match(/\.(\d+)/)[1] || 0
    
    signs = remainder.to_s.size- 1
    
    it = [["десятая", "десятых"]]
    it << ["сотая", "сотых"]
    it << ["тысячная", "тысячных"]
    it << ["десятитысячная", "десятитысячных"]
    it << ["стотысячная", "стотысячных"]
    it << ["миллионная", "милллионных"]
    it << ["десятимиллионная", "десятимилллионных", "десятимиллионных"]
    it << ["стомиллионная", "стомилллионных", "стомиллионных"]
    it << ["миллиардная", "миллиардных", "миллиардных"]
    it << ["десятимиллиардная", "десятимиллиардных", "десятимиллиардных"]
    it << ["стомиллиардная", "стомиллиардных", "стомиллиардных"]
    it << ["триллионная", "триллионных", "триллионных"]

    while it[signs].nil?
      remainder = (remainder/10).round
      signs = remainder.to_s.size- 1
    end

    suf1, suf2, suf3 = it[signs][0], it[signs][1], it[signs][2]
    
    [st, sum_string(remainder.to_i, 2, suf1, suf2, suf2)].join(" ")
  end
  
  def propisju_items(items, gender = 1, *forms)
    if items == items.to_i
      return sum_string(items, gender, *forms)
    else
      propisju(items, gender) + " " + forms[1]
    end
  end
  
  
  # Выбирает корректный вариант числительного в зависимости от рода и числа и оформляет сумму прописью
  #   234.propisju => "двести сорок три"
  #   221.propisju(2) => "двести двадцать одна"
  def propisju_int(amount, gender = 1)
    sum_string(amount, gender, "")
  end
  
  alias_method :rublja, :rublej
  alias_method :rubl, :rublej
  
  alias_method :kopeika, :kopeek
  alias_method :kopeiki, :kopeek
  
  alias_method :grivna, :griven
  alias_method :grivny, :griven
  
  
  public_instance_methods(true).map{|m| module_function(m) }
  
  module_function :propisju_int, :propisju_float
end
