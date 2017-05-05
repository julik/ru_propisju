# -*- encoding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

require "test/unit"
require "ru_propisju"

class TestRuPropisju < Test::Unit::TestCase

  def test_amount_in_words
    assert_raise(RuPropisju::UnknownCurrency) do
      RuPropisju.amount_in_words(123, "neumelix programmista")
    end

    assert_equal "ноль белорусских рублей 10 копеек", RuPropisju.bel_rublej(0.10)
    # russian locale
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, :rur)
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, :rub)
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, "RUR")
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, "rur")
    assert_equal "сто двадцать три гривны", RuPropisju.amount_in_words(123, "uah")
    assert_equal "сто двадцать три тенге", RuPropisju.amount_in_words(123, "kzt")
    assert_equal "сто двадцать три евро", RuPropisju.amount_in_words(123, "eur")
    assert_equal "сто двадцать три евро четырнадцать центов", RuPropisju.amount_in_words(123.14, "eur")
    assert_equal "сто двадцать три доллара четырнадцать центов", RuPropisju.amount_in_words(123.14, "usd")

    # russian locale (предложный падеж)
    assert_equal "ста двадцати трёх рублях", RuPropisju.amount_in_words(123, :rur, :ru_in)
    assert_equal "ста двадцати трёх рублях", RuPropisju.amount_in_words(123, :rub, :ru_in)
    assert_equal "ста двадцати трёх рублях", RuPropisju.amount_in_words(123, "RUR", "ru_in")
    assert_equal "ста двадцати трёх рублях", RuPropisju.amount_in_words(123, "rur", "ru_in")
    assert_equal "ста двадцати трёх гривнах", RuPropisju.amount_in_words(123, "uah", "ru_in")
    assert_equal "ста двадцати трёх тенге", RuPropisju.amount_in_words(123, "kzt", "ru_in")
    assert_equal "ста двадцати трёх евро", RuPropisju.amount_in_words(123, "eur", "ru_in")
    assert_equal "ста двадцати трёх евро четырнадцати центах", RuPropisju.amount_in_words(123.14, "eur", :ru_in)
    assert_equal "ста двадцати трёх долларах четырнадцати центах", RuPropisju.amount_in_words(123.14, "usd", :ru_in)

    assert_equal 'ста двадцати трёх рублях', RuPropisju.amount_in_words(123, :rur, :ru_pre)
    assert_equal 'ста двадцати трёх евро',   RuPropisju.amount_in_words(123, :eur, :ru_pre)

    # russian locale (родительный падеж)
    assert_equal 'одного рубля',             RuPropisju.amount_in_words(1, :rur, :ru_gen)
    assert_equal 'пятидесяти одного рубля',  RuPropisju.amount_in_words(51, :rur, :ru_gen)
    assert_equal 'ста двадцати трёх рублей', RuPropisju.amount_in_words(123, :rur, :ru_gen)
    assert_equal 'ста двадцати трёх рублей', RuPropisju.amount_in_words(123, :rub, :ru_gen)
    assert_equal 'ста двадцати трёх рублей', RuPropisju.amount_in_words(123, 'RUR', 'ru_gen')
    assert_equal 'ста двадцати трёх рублей', RuPropisju.amount_in_words(123, 'rur', 'ru_gen')
    assert_equal 'ста двадцати трёх гривен', RuPropisju.amount_in_words(123, 'uah', 'ru_gen')
    assert_equal 'ста двадцати трёх тенге',  RuPropisju.amount_in_words(123, 'kzt', 'ru_gen')
    assert_equal 'ста двадцати трёх евро',   RuPropisju.amount_in_words(123, 'eur', 'ru_gen')
    assert_equal 'ста двадцати трёх евро четырнадцати центов', RuPropisju.amount_in_words(123.14, 'eur', :ru_gen)
    assert_equal 'ста двадцати трёх долларов четырнадцати центов', RuPropisju.amount_in_words(123.14, 'usd', :ru_gen)

    # russian locale (творительный падеж)
    assert_equal "ста двадцатью тремя рублями", RuPropisju.amount_in_words(123, :rur, :ru_from)
    assert_equal "ста двадцатью тремя рублями", RuPropisju.amount_in_words(123, :rub, :ru_from)
    assert_equal "ста двадцатью тремя рублями", RuPropisju.amount_in_words(123, "RUR", "ru_from")
    assert_equal "ста двадцатью тремя рублями", RuPropisju.amount_in_words(123, "rur", "ru_from")
    assert_equal "ста двадцатью тремя гривнами", RuPropisju.amount_in_words(123, "uah", "ru_from")
    assert_equal "ста двадцатью тремя тенге", RuPropisju.amount_in_words(123, "kzt", "ru_from")
    assert_equal "ста двадцатью тремя евро", RuPropisju.amount_in_words(123, "eur", "ru_from")
    assert_equal "ста двадцатью тремя евро четырнадцатью центами", RuPropisju.amount_in_words(123.14, "eur", :ru_from)
    assert_equal "ста двадцатью тремя долларами четырнадцатью центами", RuPropisju.amount_in_words(123.14, "usd", :ru_from)

    # ua locale
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, :rur, :ua)
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, :rub, :ua)
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, "RUR", "ua")
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, "rur", "ua")
    assert_equal "сто двадцять три гривні", RuPropisju.amount_in_words(123, "uah", "ua")
    assert_equal "сто двадцять три тенге", RuPropisju.amount_in_words(123, "kzt", "ua")
    assert_equal "сто двадцять три євро", RuPropisju.amount_in_words(123, "eur", "ua")
    assert_equal "сто двадцять три євро чотирнадцять євроцентів", RuPropisju.amount_in_words(123.14, "eur", :ua)
    assert_equal "сто двадцять три долара чотирнадцять центів", RuPropisju.amount_in_words(123.14, "usd", :ua)
  end

  def test_issue_3
    assert_equal "два миллиона евро", RuPropisju.evro(2000000)
    assert_equal "два миллиона рублей", RuPropisju.rublej(2000000)
    assert_equal "два миллиона тенге", RuPropisju.tenge(2000000)
    assert_equal "два миллиона рублей", RuPropisju.amount_in_words(2000000, :rub)
  end

  def test_propisju_dollarov
    assert_equal "сто двадцать один доллар пятьдесят один цент", RuPropisju.dollarov(121.51)
    assert_equal "сто двадцять один долар п'ятьдесят один цент", RuPropisju.dollarov(121.51, :ua)
  end

  def test_propisju_euro
    assert_equal "сто двадцать один евро четыре цента", RuPropisju.evro(121.04)
    assert_equal "сто двадцять один євро чотири євроцента", RuPropisju.evro(121.04, :ua)
  end

  def test_propisju_tenge
    assert_equal "сто двадцать один тенге четыре тиына", RuPropisju.tenge(121.04)
    assert_equal "сто двадцять один тенге чотири тиына", RuPropisju.tenge(121.04, :ua)
  end

  def test_thousands_and_millions
    assert_equal "два миллиона сто тысяч рублей", RuPropisju.amount_in_words(2100000, :rur)
  end

  def test_propisju_for_ints
    assert_equal "пятьсот двадцать три", RuPropisju.propisju(523, 1)
    assert_equal "шесть тысяч семьсот двадцать семь", RuPropisju.propisju(6727, 1)
    assert_equal "один миллион один", RuPropisju.propisju(1_000_001, 1)
    assert_equal "один миллион", RuPropisju.propisju(1_000_000, 1)
    assert_equal "восемь миллионов шестьсот пятьдесят два", RuPropisju.propisju(8000652, 1)
    assert_equal "восемь миллионов шестьсот пятьдесят две", RuPropisju.propisju(8000652, 2)
    assert_equal "восемь миллионов шестьсот пятьдесят два", RuPropisju.propisju(8000652, 3)
    assert_equal "сорок пять", RuPropisju.propisju(45, 1)
    assert_equal "пять", RuPropisju.propisju(5, 1)
    assert_equal "шестьсот двенадцать", RuPropisju.propisju(612, 1)
    assert_equal "ноль", RuPropisju.propisju(0, 1)


    # предложный падеж для русской локали
    assert_equal "пятистах двадцати трёх", RuPropisju.propisju(523, 1, :ru_in)
    assert_equal "шести тысячах семистах двадцати семи", RuPropisju.propisju(6727, 1, :ru_in)
    assert_equal "одном миллионе одном", RuPropisju.propisju(1_000_001, 1, :ru_in)
    assert_equal "одном миллионе", RuPropisju.propisju(1_000_000, 1, :ru_in)
    assert_equal "восьми миллионах шестистах пятидесяти двух", RuPropisju.propisju(8000652, 1, :ru_in)
    assert_equal "восьми миллионах шестистах пятидесяти двух", RuPropisju.propisju(8000652, 2, :ru_in)
    assert_equal "восьми миллионах шестистах пятидесяти двух", RuPropisju.propisju(8000652, 3, :ru_in)
    assert_equal "сорока пяти", RuPropisju.propisju(45, 1, :ru_in)
    assert_equal "пяти", RuPropisju.propisju(5, 1, :ru_in)
    assert_equal "шестистах двенадцати", RuPropisju.propisju(612, 1, :ru_in)
    assert_equal "нуле", RuPropisju.propisju(0, 1, :ru_in)

    # родительный падеж для русской локали
    assert_equal 'пятисот двадцати трёх',             RuPropisju.propisju(523, 1, :ru_gen)
    assert_equal 'шести тысяч семисот двадцати семи', RuPropisju.propisju(6727, 1, :ru_gen)
    assert_equal 'одного миллиона одного',            RuPropisju.propisju(1_000_001, 1, :ru_gen)
    assert_equal 'одного миллиона',                   RuPropisju.propisju(1_000_000, 1, :ru_gen)
    assert_equal 'восьми миллионов шестисот пятидесяти одного', RuPropisju.propisju(8000651, 1, :ru_gen)
    assert_equal 'восьми миллионов шестисот пятидесяти одной',  RuPropisju.propisju(8000651, 2, :ru_gen)
    assert_equal 'восьми миллионов шестисот пятидесяти одного', RuPropisju.propisju(8000651, 3, :ru_gen)
    assert_equal 'сорока пяти', RuPropisju.propisju(45, 1, :ru_gen)
    assert_equal 'пяти', RuPropisju.propisju(5, 1, :ru_gen)
    assert_equal 'шестисот двенадцати', RuPropisju.propisju(612, 1, :ru_gen)
    assert_equal 'нуля', RuPropisju.propisju(0, 1, :ru_gen)

    # творительный падеж для русской локали
    assert_equal "пятьюстами двадцатью тремя", RuPropisju.propisju(523, 1, :ru_from)
    assert_equal "шестью тысячами семьюстами двадцатью семью", RuPropisju.propisju(6727, 1, :ru_from)
    assert_equal "одним миллионом одним", RuPropisju.propisju(1_000_001, 1, :ru_from)
    assert_equal "одним миллионом", RuPropisju.propisju(1_000_000, 1, :ru_from)
    assert_equal "восьмью миллионами шестьюстами пятьюдесятью двумя", RuPropisju.propisju(8000652, 1, :ru_from)
    assert_equal "восьмью миллионами шестьюстами пятьюдесятью двумя", RuPropisju.propisju(8000652, 2, :ru_from)
    assert_equal "восьмью миллионами шестьюстами пятьюдесятью двумя", RuPropisju.propisju(8000652, 3, :ru_from)
    assert_equal "сорока пятью", RuPropisju.propisju(45, 1, :ru_from)
    assert_equal "пятью", RuPropisju.propisju(5, 1, :ru_from)
    assert_equal "шестьюстами двенадцатью", RuPropisju.propisju(612, 1, :ru_from)
    assert_equal "нулём", RuPropisju.propisju(0, 1, :ru_from)


    # ukrainian locale
    assert_equal "п'ятьсот двадцять три", RuPropisju.propisju(523, 1, :ua)
    assert_equal "шість тисяч сімсот двадцять сім", RuPropisju.propisju(6727, 1, :ua)
    assert_equal "вісім мільйонів шістсот п'ятьдесят два", RuPropisju.propisju(8000652, 1, :ua)
    assert_equal "вісім мільйонів шістсот п'ятьдесят дві", RuPropisju.propisju(8000652, 2, :ua)
    assert_equal "вісім мільйонів шістсот п'ятьдесят два", RuPropisju.propisju(8000652, 3, :ua)
    assert_equal "сорок п'ять", RuPropisju.propisju(45, 1, :ua)
    assert_equal "п'ять", RuPropisju.propisju(5, 1, :ua)
    assert_equal "шістсот дванадцять", RuPropisju.propisju(612, 1, :ua)

  end

  def test_propisju_shtuk
    assert_equal "шесть целых", RuPropisju.propisju_shtuk(6, 2, ["целая", "целых", "целых"])
    assert_equal "двадцать пять колес", RuPropisju.propisju_shtuk(25, 3, ["колесо", "колеса", "колес"])
    assert_equal "двадцать одна подстава", RuPropisju.propisju_shtuk(21, 2, ["подстава", "подставы", "подстав"])
    assert_equal "двести двенадцать сволочей", RuPropisju.propisju_shtuk(212.00, 2, ["сволочь", "сволочи", "сволочей"])
    assert_equal "двести двенадцать целых четыре десятых куска", RuPropisju.propisju_shtuk(212.40, 2, ["кусок", "куска", "кусков"])

    # GH issue 10
    # https://github.com/julik/ru_propisju/issues/10
    assert_equal "одна тысяча сто две целых сорок одна сотая кубометра", RuPropisju.propisju_shtuk( 1102.41, 2, ["кубометр", "кубометра", "кубометров"])

    # предложный падеж русской локали
    assert_equal "шести целых", RuPropisju.propisju_shtuk(6, 2, ["целой", "целых", "целых"], :ru_in)
    assert_equal "двадцати пяти колесах", RuPropisju.propisju_shtuk(25, 3, ["колесо", "колесах", "колесах"], :ru_in)
    assert_equal "двадцати одной подставе", RuPropisju.propisju_shtuk(21, 2, ["подставе", "подставах", "подставах"], :ru_in)
    assert_equal "двухстах двенадцати сволочах", RuPropisju.propisju_shtuk(212.00, 2, ["сволочи", "сволочах", "сволочах"], :ru_in)
    assert_equal "двухстах двенадцати целых четырёх десятых кусках", RuPropisju.propisju_shtuk(212.40, 2, ["куске", "кусках", "кусках"], :ru_in)

    # родительный падеж русской локали
    assert_equal 'шести целых',                 RuPropisju.propisju_shtuk(6, 2, %w(целой целых целых), :ru_gen)
    assert_equal 'двадцати пяти колёс',         RuPropisju.propisju_shtuk(25, 3, %w(колёса колёс колёс), :ru_gen)
    assert_equal 'двадцати одной подставы',     RuPropisju.propisju_shtuk(21, 2, %w(подставы подстав подстав), :ru_gen)
    assert_equal 'двухсот двенадцати сволочей', RuPropisju.propisju_shtuk(212.00, 2, %w(сволочи сволочей сволочей), :ru_gen)
    assert_equal 'двухсот двенадцати целых четырёх десятых кусков', RuPropisju.propisju_shtuk(212.40, 2, %w(куска кусков кусков), :ru_gen)

    # творительный падеж русской локали
    assert_equal "шестью целыми", RuPropisju.propisju_shtuk(6, 2, ["целой", "целыми", "целыми"], :ru_from)
    assert_equal "двадцатью пятью колесами", RuPropisju.propisju_shtuk(25, 3, ["колесом", "колесами", "колесами"], :ru_from)
    assert_equal "двадцатью одной подставой", RuPropisju.propisju_shtuk(21, 2, ["подставой", "подставами", "подставами"], :ru_from)
    assert_equal "двумястами двенадцатью сволочами", RuPropisju.propisju_shtuk(212.00, 2, ["сволочью", "сволочами", "сволочами"], :ru_from)
    assert_equal "двумястами двенадцатью целыми четырьмя десятыми кусками", RuPropisju.propisju_shtuk(212.40, 2, ["куском", "кусками", "кусками"], :ru_from)

    # ua locale
    assert_equal "шість цілих", RuPropisju.propisju_shtuk(6, 2, ["ціла", "цілих", "цілих"], :ua)
    assert_equal "двадцять п'ять колес", RuPropisju.propisju_shtuk(25, 3, ["колесо", "колеса", "колес"], :ua)
    assert_equal "двадцять одна підстава", RuPropisju.propisju_shtuk(21, 2, ["підстава", "підстави", "підстав"], :ua)
    assert_equal "двісті дванадцять наволочів", RuPropisju.propisju_shtuk(212.00, 2, ["наволоч", "наволочі", "наволочів"], :ua)
    assert_equal "двісті дванадцять цілих чотири десятих шматка", RuPropisju.propisju_shtuk(212.40, 2, ["шматок", "шматка", "шматків"], :ua)
  end

  def test_propisju_for_floats
    assert_equal "шесть целых пять десятых", RuPropisju.propisju(6.50, 1)
    assert_equal "шесть", RuPropisju.propisju(6.0, 1)
    assert_equal "тридцать миллиардов целых сто одиннадцать тысячных", RuPropisju.propisju(3 * 10**10 + 0.111, 1)
    assert_equal "тридцать", RuPropisju.propisju(30.0, 1)
    assert_equal "тридцать целых одна десятая", RuPropisju.propisju(30.1, 1)
    assert_equal "триста сорок одна целая девять десятых", RuPropisju.propisju(341.9, 1)
    assert_equal "триста сорок одна целая двести сорок пять тысячных", RuPropisju.propisju(341.245, 1)
    assert_equal "двести три целых сорок одна сотая", RuPropisju.propisju(203.41, 1)
    assert_equal "четыреста сорок две целых пять десятых", RuPropisju.propisju(442.50000, 1)

    # предложный падеж русской локали
    assert_equal "шести целых пяти десятых", RuPropisju.propisju(6.50, 1, :ru_in)
    assert_equal "шести", RuPropisju.propisju(6.0, 1, :ru_in)
    assert_equal "тридцати миллиардах целых ста одиннадцати тысячных", RuPropisju.propisju(3 * 10**10 + 0.111, 1, :ru_in)
    assert_equal "тридцати", RuPropisju.propisju(30.0, 1, :ru_in)
    assert_equal "тридцати целых одной десятой", RuPropisju.propisju(30.1, 1, :ru_in)
    assert_equal "трёхстах сорока одной целой девяти десятых", RuPropisju.propisju(341.9, 1, :ru_in)
    assert_equal "трёхстах сорока одной целой двухстах сорока пяти тысячных", RuPropisju.propisju(341.245, 1, :ru_in)
    assert_equal "двухстах трёх целых сорока одной сотой", RuPropisju.propisju(203.41, 1, :ru_in)
    assert_equal "четырёхстах сорока двух целых пяти десятых", RuPropisju.propisju(442.50000, 1, :ru_in)

    # родительный падеж русской локали
    assert_equal 'шести целых пяти десятых',                                RuPropisju.propisju(6.50, 1, :ru_gen)
    assert_equal 'шести',                                                   RuPropisju.propisju(6.0, 1, :ru_gen)
    assert_equal 'тридцати миллиардов целых ста одиннадцати тысячных',      RuPropisju.propisju(3 * 10**10 + 0.111, 1, :ru_gen)
    assert_equal 'тридцати',                                                RuPropisju.propisju(30.0, 1, :ru_gen)
    assert_equal 'тридцати целых одной десятой',                            RuPropisju.propisju(30.1, 1, :ru_gen)
    assert_equal 'трёхсот сорока одной целой девяти десятых',               RuPropisju.propisju(341.9, 1, :ru_gen)
    assert_equal 'трёхсот сорока одной целой двухсот сорока пяти тысячных', RuPropisju.propisju(341.245, 1, :ru_gen)
    assert_equal 'двухсот трёх целых сорока одной сотой',                   RuPropisju.propisju(203.41, 1, :ru_gen)
    assert_equal 'четырёхсот сорока двух целых пяти десятых',               RuPropisju.propisju(442.50000, 1, :ru_gen)

    # творительный падеж русской локали
    assert_equal "шестью целыми пятью десятыми", RuPropisju.propisju(6.50, 1, :ru_from)
    assert_equal "шестью", RuPropisju.propisju(6.0, 1, :ru_from)
    assert_equal "тридцатью миллиардами целыми ста одиннадцатью тысячными", RuPropisju.propisju(3 * 10**10 + 0.111, 1, :ru_from)
    assert_equal "тридцатью", RuPropisju.propisju(30.0, 1, :ru_from)
    assert_equal "тридцатью целыми одной десятой", RuPropisju.propisju(30.1, 1, :ru_from)
    assert_equal "тремястами сорока одной целой девятью десятыми", RuPropisju.propisju(341.9, 1, :ru_from)
    assert_equal "тремястами сорока одной целой двумястами сорока пятью тысячными", RuPropisju.propisju(341.245, 1, :ru_from)
    assert_equal "двумястами тремя целыми сорока одной сотой", RuPropisju.propisju(203.41, 1, :ru_from)
    assert_equal "четырьмястами сорока двумя целыми пятью десятыми", RuPropisju.propisju(442.50000, 1, :ru_from)

    # ua locale
    assert_equal "шість цілих п'ять десятих", RuPropisju.propisju(6.50, 1, :ua)
    assert_equal "триста сорок одна ціла дев'ять десятих", RuPropisju.propisju(341.9, 1, :ua)
    assert_equal "триста сорок одна ціла двісті сорок п'ять тисячних", RuPropisju.propisju(341.245, 1, :ua)
    assert_equal "двісті три цілих сорок одна сота", RuPropisju.propisju(203.41, 1, :ua)
    assert_equal "чотириста сорок дві цілих п'ять десятих", RuPropisju.propisju(442.50000, 1, :ua)

    # unknown locale
    assert_raise(RuPropisju::UnknownLocale) do
      assert_equal "чотириста сорок дві цілих п'ять десятих", RuPropisju.propisju(442.50000, 1, :kg)
    end
  end


  def test_choose_plural
    assert_equal "чемодана", RuPropisju.choose_plural(523, ["чемодан", "чемодана", "чемоданов"])
    assert_equal "партий", RuPropisju.choose_plural(6727, ["партия", "партии", "партий"])
    assert_equal "козлов", RuPropisju.choose_plural(45, ["козел", "козла", "козлов"])
    assert_equal "колес", RuPropisju.choose_plural(260, ["колесо", "колеса", "колес"])

    # splat args
    assert_equal "колес", RuPropisju.choose_plural(260, "колесо", "колеса", "колес")

    # ua locale
    assert_equal "валізи", RuPropisju.choose_plural(523, ["валіза", "валізи", "валіз"])
    assert_equal "партій", RuPropisju.choose_plural(6727, ["партія", "партії", "партій"])
    assert_equal "козлів", RuPropisju.choose_plural(45, ["козел", "козла", "козлів"])
    assert_equal "колес", RuPropisju.choose_plural(260, ["колесо", "колеса", "колес"])
  end

  def test_rublej
    assert_equal "ноль рублей 0 копеек", RuPropisju.rublej(0)
    assert_equal "сто двадцать три рубля", RuPropisju.rublej(123)
    assert_equal "триста сорок три рубля 20 копеек", RuPropisju.rublej(343.20)
    assert_equal "42 копейки", RuPropisju.rublej(0.4187)
    assert_equal "триста тридцать два рубля", RuPropisju.rublej(331.995)
    assert_equal "один рубль", RuPropisju.rubl(1)
    assert_equal "три рубля 14 копеек", RuPropisju.rublja(3.14)
    assert_equal "три рубля 2 копейки", RuPropisju.rublja(3.02)
    assert_equal "одна тысяча рублей", RuPropisju.rublja(1000)
    assert_equal "одна тысяча рублей", RuPropisju.rublja(1000.0)
    assert_equal "1000 рублей", RuPropisju.digit_rublej(1000)
    assert_equal "345 рублей 2 копейки", RuPropisju.digit_rublej(345.02)

    # ru locale предложный падеж
    assert_equal "нуле рублях 0 копейках", RuPropisju.rublej(0, :ru_in)
    assert_equal "ста двадцати трёх рублях", RuPropisju.rublej(123, :ru_in)
    assert_equal "трёхстах сорока трёх рублях 20 копейках", RuPropisju.rublej(343.20, :ru_in)
    assert_equal "42 копейках", RuPropisju.rublej(0.4187, :ru_in)
    assert_equal "трёхстах тридцати двух рублях", RuPropisju.rublej(331.995, :ru_in)
    assert_equal "одном рубле", RuPropisju.rubl(1, :ru_in)
    assert_equal "трёх рублях 14 копейках", RuPropisju.rublja(3.14, :ru_in)

    # ru locale родительный падеж
    assert_equal 'нуля рублей 0 копеек',                 RuPropisju.rublej(0, :ru_gen)
    assert_equal 'ста двадцати трёх рублей',             RuPropisju.rublej(123, :ru_gen)
    assert_equal 'трёхсот сорока трёх рублей 20 копеек', RuPropisju.rublej(343.20, :ru_gen)
    assert_equal '42 копеек',                            RuPropisju.rublej(0.4187, :ru_gen)
    assert_equal 'трёхсот тридцати двух рублей',         RuPropisju.rublej(331.995, :ru_gen)
    assert_equal 'одного рубля',                         RuPropisju.rubl(1, :ru_gen)
    assert_equal 'трёх рублей 14 копеек',                RuPropisju.rublja(3.14, :ru_gen)

    # ru locale творительный падеж
    assert_equal "нулём рублями 0 копейками", RuPropisju.rublej(0, :ru_from)
    assert_equal "ста двадцатью тремя рублями", RuPropisju.rublej(123, :ru_from)
    assert_equal "тремястами сорока тремя рублями 20 копейками", RuPropisju.rublej(343.20, :ru_from)
    assert_equal "42 копейками", RuPropisju.rublej(0.4187, :ru_from)
    assert_equal "тремястами тридцатью двумя рублями", RuPropisju.rublej(331.995, :ru_from)
    assert_equal "одним рублём", RuPropisju.rubl(1, :ru_from)
    assert_equal "тремя рублями 14 копейками", RuPropisju.rublja(3.14, :ru_from)

    # ua locale
    assert_equal "сто двадцять три рубля", RuPropisju.rublej(123, :ua)
    assert_equal "триста сорок три рубля 20 копійок", RuPropisju.rublej(343.20, :ua)
    assert_equal "42 копійки", RuPropisju.rublej(0.4187, :ua)
    assert_equal "триста тридцять два рубля", RuPropisju.rublej(331.995, :ua)
    assert_equal "один рубль", RuPropisju.rubl(1, :ua)
    assert_equal "три рубля 14 копійок", RuPropisju.rublja(3.14, :ua)
  end

  def test_griven
    assert_equal "сто двадцать три гривны", RuPropisju.griven(123)
    assert_equal "сто двадцать четыре гривны", RuPropisju.griven(124)
    assert_equal "триста сорок три гривны двадцать копеек", RuPropisju.griven(343.20)
    assert_equal "сорок две копейки", RuPropisju.griven(0.4187)
    assert_equal "триста тридцать две гривны", RuPropisju.griven(331.995)
    assert_equal "одна гривна", RuPropisju.grivna(1)
    assert_equal "три гривны четырнадцать копеек", RuPropisju.grivny(3.14)
    assert_equal "ноль гривен ноль копеек", RuPropisju.griven(0)

    # ru locale предложный падеж
    assert_equal "ста двадцати трёх гривнах", RuPropisju.griven(123, :ru_in)
    assert_equal "ста двадцати четырёх гривнах", RuPropisju.griven(124, :ru_in)
    assert_equal "трёхстах сорока трёх гривнах двадцати копейках", RuPropisju.griven(343.20, :ru_in)
    assert_equal "сорока двух копейках", RuPropisju.griven(0.4187, :ru_in)
    assert_equal "трёхстах тридцати двух гривнах", RuPropisju.griven(331.995, :ru_in)
    assert_equal "одной гривне", RuPropisju.grivna(1, :ru_in)
    assert_equal "трёх гривнах четырнадцати копейках", RuPropisju.grivny(3.14, :ru_in)
    assert_equal "нуле гривнах нуле копейках", RuPropisju.griven(0, :ru_in)

    # ru locale родительный падеж
    assert_equal 'ста двадцати трёх гривен',                   RuPropisju.griven(123, :ru_gen)
    assert_equal 'ста двадцати четырёх гривен',                RuPropisju.griven(124, :ru_gen)
    assert_equal 'трёхсот сорока трёх гривен двадцати копеек', RuPropisju.griven(343.20, :ru_gen)
    assert_equal 'сорока двух копеек',                         RuPropisju.griven(0.4187, :ru_gen)
    assert_equal 'трёхсот тридцати двух гривен',               RuPropisju.griven(331.995, :ru_gen)
    assert_equal 'одной гривны',                               RuPropisju.grivna(1, :ru_gen)
    assert_equal 'трёх гривен четырнадцати копеек',            RuPropisju.grivny(3.14, :ru_gen)
    assert_equal 'нуля гривен нуля копеек',                    RuPropisju.griven(0, :ru_gen)

    # ru locale творительный падеж
    assert_equal "ста двадцатью тремя гривнами", RuPropisju.griven(123, :ru_from)
    assert_equal "ста двадцатью четырьмя гривнами", RuPropisju.griven(124, :ru_from)
    assert_equal "тремястами сорока тремя гривнами двадцатью копейками", RuPropisju.griven(343.20, :ru_from)
    assert_equal "сорока двумя копейками", RuPropisju.griven(0.4187, :ru_from)
    assert_equal "тремястами тридцатью двумя гривнами", RuPropisju.griven(331.995, :ru_from)
    assert_equal "одной гривной", RuPropisju.grivna(1, :ru_from)
    assert_equal "тремя гривнами четырнадцатью копейками", RuPropisju.grivny(3.14, :ru_from)
    assert_equal "нулём гривнами нулём копейками", RuPropisju.griven(0, :ru_from)

    # ua locale
    assert_equal "сто двадцять три гривні", RuPropisju.griven(123, :ua)
    assert_equal "сто двадцять чотири гривні", RuPropisju.griven(124, :ua)
    assert_equal "триста сорок три гривні двадцять копійок", RuPropisju.griven(343.20, :ua)
    assert_equal "сорок дві копійки", RuPropisju.griven(0.4187, :ua)
    assert_equal "триста тридцять дві гривні", RuPropisju.griven(331.995, :ua)
    assert_equal "одна гривня", RuPropisju.grivna(1, :ua)
    assert_equal "три гривні чотирнадцять копійок", RuPropisju.grivny(3.14, :ua)
    assert_equal "нуль гривень нуль копійок", RuPropisju.griven(0, :ua)
  end

  def test_tenge
    assert_equal "сто двадцать три тенге", RuPropisju.tenge(123)
    assert_equal "сто двадцать четыре тенге", RuPropisju.tenge(124)
    assert_equal "триста сорок три тенге двадцать тиынов", RuPropisju.tenge(343.20)
    assert_equal "сорок два тиына", RuPropisju.tenge(0.4187)
    assert_equal "триста тридцать два тенге", RuPropisju.tenge(331.995)
    assert_equal "триста тридцать один тенге девяносто девять тиынов", RuPropisju.tenge(331.985)
    assert_equal "один тенге", RuPropisju.tenge(1)
    assert_equal "три тенге четырнадцать тиынов", RuPropisju.tenge(3.14)
    assert_equal "ноль тенге ноль тиынов", RuPropisju.tenge(0)

    # ru locale предложный падеж
    assert_equal "ста двадцати трёх тенге", RuPropisju.tenge(123, :ru_in)
    assert_equal "ста двадцати четырёх тенге", RuPropisju.tenge(124, :ru_in)
    assert_equal "трёхстах сорока трёх тенге двадцати тиынах", RuPropisju.tenge(343.20, :ru_in)
    assert_equal "сорока двух тиынах", RuPropisju.tenge(0.4187, :ru_in)
    assert_equal "трёхстах тридцати двух тенге", RuPropisju.tenge(331.995, :ru_in)
    assert_equal "трёхстах тридцати одном тенге девяноста девяти тиынах", RuPropisju.tenge(331.985, :ru_in)
    assert_equal "одном тенге", RuPropisju.tenge(1, :ru_in)
    assert_equal "трёх тенге четырнадцати тиынах", RuPropisju.tenge(3.14, :ru_in)
    assert_equal "нуле тенге нуле тиынах", RuPropisju.tenge(0, :ru_in)

    # ru locale родительный падеж
    assert_equal 'ста двадцати трёх тенге',                               RuPropisju.tenge(123, :ru_gen)
    assert_equal 'ста двадцати четырёх тенге',                            RuPropisju.tenge(124, :ru_gen)
    assert_equal 'трёхсот сорока трёх тенге двадцати тиынов',             RuPropisju.tenge(343.20, :ru_gen)
    assert_equal 'сорока двух тиынов',                                    RuPropisju.tenge(0.4187, :ru_gen)
    assert_equal 'трёхсот тридцати двух тенге',                           RuPropisju.tenge(331.995, :ru_gen)
    assert_equal 'трёхсот тридцати одного тенге девяноста девяти тиынов', RuPropisju.tenge(331.985, :ru_gen)
    assert_equal 'одного тенге',                                          RuPropisju.tenge(1, :ru_gen)
    assert_equal 'трёх тенге четырнадцати тиынов',                        RuPropisju.tenge(3.14, :ru_gen)
    assert_equal 'нуля тенге нуля тиынов',                                RuPropisju.tenge(0, :ru_gen)

    # ru locale творительный падеж
    assert_equal "ста двадцатью тремя тенге", RuPropisju.tenge(123, :ru_from)
    assert_equal "ста двадцатью четырьмя тенге", RuPropisju.tenge(124, :ru_from)
    assert_equal "тремястами сорока тремя тенге двадцатью тиынами", RuPropisju.tenge(343.20, :ru_from)
    assert_equal "сорока двумя тиынами", RuPropisju.tenge(0.4187, :ru_from)
    assert_equal "тремястами тридцатью двумя тенге", RuPropisju.tenge(331.995, :ru_from)
    assert_equal "тремястами тридцатью одним тенге девяноста девятью тиынами", RuPropisju.tenge(331.985, :ru_from)
    assert_equal "одним тенге", RuPropisju.tenge(1, :ru_from)
    assert_equal "тремя тенге четырнадцатью тиынами", RuPropisju.tenge(3.14, :ru_from)
    assert_equal "нулём тенге нулём тиынами", RuPropisju.tenge(0, :ru_from)

    # ua locale
    assert_equal "сто двадцять три тенге", RuPropisju.tenge(123, :ua)
    assert_equal "триста сорок три тенге двадцять тиынов", RuPropisju.tenge(343.20, :ua)
    assert_equal "сорок два тиына", RuPropisju.tenge(0.4187, :ua)
    assert_equal "триста тридцять два тенге", RuPropisju.tenge(331.995, :ua)
    assert_equal "один тенге", RuPropisju.tenge(1, :ua)
    assert_equal "три тенге чотирнадцять тиынов", RuPropisju.tenge(3.14, :ua)
  end

  def test_kopeek
    assert_equal "ноль рублей 0 копеек", RuPropisju.kopeek(0)
    assert_equal "сто двадцать три рубля", RuPropisju.kopeek(12300)
    assert_equal "три рубля 14 копеек", RuPropisju.kopeek(314)
    assert_equal "32 копейки", RuPropisju.kopeek(32)
    assert_equal "21 копейка", RuPropisju.kopeika(21)
    assert_equal "3 копейки", RuPropisju.kopeiki(3)

    # ru locale предложный падеж
    assert_equal "нуле рублях 0 копейках", RuPropisju.kopeek(0, :ru_in)
    assert_equal "ста двадцати трёх рублях", RuPropisju.kopeek(12300, :ru_in)
    assert_equal "трёх рублях 14 копейках", RuPropisju.kopeek(314, :ru_in)
    assert_equal "32 копейках", RuPropisju.kopeek(32, :ru_in)
    assert_equal "21 копейке", RuPropisju.kopeika(21, :ru_in)
    assert_equal "3 копейках", RuPropisju.kopeiki(3, :ru_in)

    # ru locale родительный падеж
    assert_equal 'нуля рублей 0 копеек',     RuPropisju.kopeek(0, :ru_gen)
    assert_equal 'ста двадцати трёх рублей', RuPropisju.kopeek(12300, :ru_gen)
    assert_equal 'трёх рублей 14 копеек',    RuPropisju.kopeek(314, :ru_gen)
    assert_equal '32 копеек',                RuPropisju.kopeek(32, :ru_gen)
    assert_equal '21 копейки',               RuPropisju.kopeika(21, :ru_gen)
    assert_equal '3 копеек',                 RuPropisju.kopeiki(3, :ru_gen)

    # ru locale творительный падеж
    assert_equal "нулём рублями 0 копейками", RuPropisju.kopeek(0, :ru_from)
    assert_equal "ста двадцатью тремя рублями", RuPropisju.kopeek(12300, :ru_from)
    assert_equal "тремя рублями 14 копейками", RuPropisju.kopeek(314, :ru_from)
    assert_equal "32 копейками", RuPropisju.kopeek(32, :ru_from)
    assert_equal "21 копейкой", RuPropisju.kopeika(21, :ru_from)
    assert_equal "3 копейками", RuPropisju.kopeiki(3, :ru_from)

    # ua locale
    assert_equal "сто двадцять три рубля", RuPropisju.kopeek(12300, :ua)
    assert_equal "три рубля 14 копійок", RuPropisju.kopeek(314, :ua)
    assert_equal "32 копійки", RuPropisju.kopeek(32, :ua)
    assert_equal "21 копійка", RuPropisju.kopeika(21, :ua)
    assert_equal "3 копійки", RuPropisju.kopeiki(3, :ua)
  end

  def test_options
    options = { :always_show_fraction => true }
    assert_equal "ноль рублей 0 копеек", RuPropisju.rublej(0, :ru, options)
    assert_equal "сто двадцать три рубля 0 копеек", RuPropisju.rublej(123, :ru, options)
    assert_equal "триста сорок три рубля 20 копеек", RuPropisju.rublej(343.20, :ru, options)
    assert_equal "триста сорок три рубля 70 копеек", RuPropisju.rublej(343.70, :ru, options)

    assert_equal "42 копейки", RuPropisju.rublej(0.4187, :ru, options)
    assert_equal "триста тридцать два рубля 0 копеек", RuPropisju.rublej(331.995, :ru, options)
    assert_equal "один рубль 0 копеек", RuPropisju.rubl(1, :ru, options)
    assert_equal "три рубля 14 копеек", RuPropisju.rublja(3.14, :ru, options)
    assert_equal "три рубля 2 копейки", RuPropisju.rublja(3.02, :ru, options)
    assert_equal "одна тысяча рублей 0 копеек", RuPropisju.rublja(1000, :ru, options)

    assert_equal "1000 рублей 0 копеек", RuPropisju.digit_rublej(1000, :ru, options)
    assert_equal "345 рублей 2 копейки", RuPropisju.digit_rublej(345.02, :ru, options)
    assert_equal "4 рубля 60 копеек", RuPropisju.digit_rublej(4.60, :ru, options)

    options_custom_formatter = { :fraction_formatter => '%02d', :integrals_formatter => '+%d', :integrals_delimiter => ' ', :always_show_fraction => true }
    assert_equal "ноль рублей 00 копеек", RuPropisju.rublej(0, :ru, options_custom_formatter)
    assert_equal "сто двадцать три рубля 00 копеек", RuPropisju.rublej(123, :ru, options_custom_formatter)
    assert_equal "триста сорок три рубля 20 копеек", RuPropisju.rublej(343.20, :ru, options_custom_formatter)

    assert_equal "42 копейки", RuPropisju.rublej(0.4187, :ru, options_custom_formatter)
    assert_equal "триста тридцать два рубля 00 копеек", RuPropisju.rublej(331.995, :ru, options_custom_formatter)
    assert_equal "один рубль 00 копеек", RuPropisju.rubl(1, :ru, options_custom_formatter)
    assert_equal "три рубля 14 копеек", RuPropisju.rublja(3.14, :ru, options_custom_formatter)
    assert_equal "три рубля 02 копейки", RuPropisju.rublja(3.02, :ru, options_custom_formatter)
    assert_equal "одна тысяча рублей 00 копеек", RuPropisju.rublja(1000, :ru, options_custom_formatter)

    assert_equal "+1 000 рублей 00 копеек", RuPropisju.digit_rublej(1000, :ru, options_custom_formatter)
    assert_equal "+1 000 рублей 00 копеек", RuPropisju.digit_rublej(1000.0, :ru, options_custom_formatter)
    assert_equal "+345 рублей 02 копейки", RuPropisju.digit_rublej(345.02, :ru, options_custom_formatter)

    assert_equal "триста тридцять дві гривні нуль копійок", RuPropisju.griven(331.995, :ua, options_custom_formatter)
    assert_equal "три тенге ноль тиынов", RuPropisju.tenge(3, :ru, options_custom_formatter)
    assert_equal "триста сорок пять долларов два цента", RuPropisju.dollarov(345.02, :ru, options_custom_formatter)
    assert_equal "три доллара ноль центов", RuPropisju.dollarov(3, :ru, options_custom_formatter)
    assert_equal "три евро ноль центов", RuPropisju.evro(3, :ru, options_custom_formatter)
  end
end
