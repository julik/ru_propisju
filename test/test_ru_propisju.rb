# -*- encoding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

require "test/unit"
require "ru_propisju"

class TestRuPropisju < Test::Unit::TestCase

  def test_amount_in_words
    assert_raise(RuPropisju::UnknownCurrency) do
      RuPropisju.amount_in_words(123, "neumelix programmista")
    end

    # russian locale
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, :rur)
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, :rub)
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, "RUR")
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, "rur")
    assert_equal "сто двадцать три гривны", RuPropisju.amount_in_words(123, "uah")
    assert_equal "сто двадцать три евро", RuPropisju.amount_in_words(123, "eur")
    assert_equal "сто двадцать три евро четырнадцать центов", RuPropisju.amount_in_words(123.14, "eur")
    assert_equal "сто двадцать три доллара четырнадцать центов", RuPropisju.amount_in_words(123.14, "usd")
    
    # ua locale
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, :rur, :ua)
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, :rub, :ua)
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, "RUR", "ua")
    assert_equal "сто двадцять три рубля", RuPropisju.amount_in_words(123, "rur", "ua")
    assert_equal "сто двадцять три гривні", RuPropisju.amount_in_words(123, "uah", "ua")
    assert_equal "сто двадцять три євро", RuPropisju.amount_in_words(123, "eur", "ua")
    assert_equal "сто двадцять три євро чотирнадцять євроцентів", RuPropisju.amount_in_words(123.14, "eur", :ua)
    assert_equal "сто двадцять три долара чотирнадцять центів", RuPropisju.amount_in_words(123.14, "usd", :ua)
  end
  
  def test_issue_3
    assert_equal "два миллиона евро", RuPropisju.evro(2000000)
    assert_equal "два миллиона рублей", RuPropisju.rublej(2000000)
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

    # ua locale
    assert_equal "шість цілих", RuPropisju.propisju_shtuk(6, 2, ["ціла", "цілих", "цілих"], :ua)
    assert_equal "двадцять п'ять колес", RuPropisju.propisju_shtuk(25, 3, ["колесо", "колеса", "колес"], :ua)
    assert_equal "двадцять одна підстава", RuPropisju.propisju_shtuk(21, 2, ["підстава", "підстави", "підстав"], :ua)
    assert_equal "двісті дванадцять наволочів", RuPropisju.propisju_shtuk(212.00, 2, ["наволоч", "наволочі", "наволочів"], :ua)
    assert_equal "двісті дванадцять цілих чотири десятих шматка", RuPropisju.propisju_shtuk(212.40, 2, ["шматок", "шматка", "шматків"], :ua)
  end

  def test_propisju_for_floats
    assert_equal "шесть целых пять десятых", RuPropisju.propisju(6.50, 1)
    assert_equal "триста сорок одна целая девять десятых", RuPropisju.propisju(341.9, 1)
    assert_equal "триста сорок одна целая двести сорок пять тысячных", RuPropisju.propisju(341.245, 1)
    assert_equal "двести три целых сорок одна сотая", RuPropisju.propisju(203.41, 1)
    assert_equal "четыреста сорок две целых пять десятых", RuPropisju.propisju(442.50000, 1)
    # ua locale
    assert_equal "шість цілих п'ять десятих", RuPropisju.propisju(6.50, 1, :ua)
    assert_equal "триста сорок одна ціла дев'ять десятих", RuPropisju.propisju(341.9, 1, :ua)
    assert_equal "триста сорок одна ціла двісті сорок п'ять тисячних", RuPropisju.propisju(341.245, 1, :ua)
    assert_equal "двісті три цілих сорок одна сота", RuPropisju.propisju(203.41, 1, :ua)
    assert_equal "чотиреста сорок дві цілих п'ять десятих", RuPropisju.propisju(442.50000, 1, :ua)
    
    # unknown locale
    assert_raise(RuPropisju::UnknownLocale) do
      assert_equal "чотиреста сорок дві цілих п'ять десятих", RuPropisju.propisju(442.50000, 1, :kg)
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
    assert_equal "сто двадцать три рубля", RuPropisju.rublej(123)
    assert_equal "триста сорок три рубля 20 копеек", RuPropisju.rublej(343.20)
    assert_equal "42 копейки", RuPropisju.rublej(0.4187)
    assert_equal "триста тридцать два рубля", RuPropisju.rublej(331.995)
    assert_equal "один рубль", RuPropisju.rubl(1)
    assert_equal "три рубля 14 копеек", RuPropisju.rublja(3.14)

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
    # ua locale
    assert_equal "сто двадцять три гривні", RuPropisju.griven(123, :ua)
    assert_equal "сто двадцять чотири гривні", RuPropisju.griven(124, :ua)
    assert_equal "триста сорок три гривні двадцять копійок", RuPropisju.griven(343.20, :ua)
    assert_equal "сорок дві копійки", RuPropisju.griven(0.4187, :ua)
    assert_equal "триста тридцять дві гривні", RuPropisju.griven(331.995, :ua)
    assert_equal "одна гривня", RuPropisju.grivna(1, :ua)
    assert_equal "три гривні чотирнадцять копійок", RuPropisju.grivny(3.14, :ua)

  end

  def test_kopeek
    assert_equal "сто двадцать три рубля", RuPropisju.kopeek(12300)
    assert_equal "три рубля 14 копеек", RuPropisju.kopeek(314)
    assert_equal "32 копейки", RuPropisju.kopeek(32)
    assert_equal "21 копейка", RuPropisju.kopeika(21)
    assert_equal "3 копейки", RuPropisju.kopeiki(3)
    # ua locale
    assert_equal "сто двадцять три рубля", RuPropisju.kopeek(12300, :ua)
    assert_equal "три рубля 14 копійок", RuPropisju.kopeek(314, :ua)
    assert_equal "32 копійки", RuPropisju.kopeek(32, :ua)
    assert_equal "21 копійка", RuPropisju.kopeika(21, :ua)
    assert_equal "3 копійки", RuPropisju.kopeiki(3, :ua)
  end
end
