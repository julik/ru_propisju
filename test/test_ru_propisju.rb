# -*- encoding: utf-8 -*- 
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

require "test/unit"
require "ru_propisju"

class TestRuPropisju < Test::Unit::TestCase
  
  def test_amount_in_words
    assert_raise(RuPropisju::UnknownCurrency) do
      RuPropisju.amount_in_words(123, "neumelix programmista")
    end
    
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, :rur)
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, "RUR")
    assert_equal "сто двадцать три рубля", RuPropisju.amount_in_words(123, "rur")
    assert_equal "сто двадцать три гривны", RuPropisju.amount_in_words(123, "uah")
    assert_equal "сто двадцать три евро", RuPropisju.amount_in_words(123, "eur")
    assert_equal "сто двадцать три евро четырнадцать центов", RuPropisju.amount_in_words(123.14, "eur")
    assert_equal "сто двадцать три доллара четырнадцать центов", RuPropisju.amount_in_words(123.14, "usd")
  end
  
  def test_propisju_dollarov
    assert_equal "сто двадцать один доллар пятьдесят один цент", RuPropisju.dollarov(121.51)
  end
  
  def test_propisju_euro
    assert_equal "сто двадцать один евро четыре цента", RuPropisju.evro(121.04)
  end
  
  def test_propisju_for_ints
    assert_equal "пятьсот двадцать три", RuPropisju.propisju(523)
    assert_equal "шесть тысяч семьсот двадцать семь", RuPropisju.propisju(6727)
    assert_equal "восемь миллионов шестьсот пятьдесят два", RuPropisju.propisju(8000652, 1)
    assert_equal "восемь миллионов шестьсот пятьдесят две", RuPropisju.propisju(8000652, 2)
    assert_equal "восемь миллионов шестьсот пятьдесят два", RuPropisju.propisju(8000652, 3)
    assert_equal "сорок пять", RuPropisju.propisju(45)
    assert_equal "пять", RuPropisju.propisju(5)
    assert_equal "шестьсот двенадцать", RuPropisju.propisju(612)
  end
  
  def test_propisju_shtuk
    assert_equal "шесть целых", RuPropisju.propisju_shtuk(6, 2, "целая", "целых", "целых")
    assert_equal "двадцать пять колес", RuPropisju.propisju_shtuk(25, 3, "колесо", "колеса", "колес")
    assert_equal "двадцать одна подстава", RuPropisju.propisju_shtuk(21, 2, "подстава", "подставы", "подстав")    
    assert_equal "двести двенадцать сволочей", RuPropisju.propisju_shtuk(212.00, 2, "сволочь", "сволочи", "сволочей")
    assert_equal "двести двенадцать целых четыре десятых куска", RuPropisju.propisju_shtuk(212.40, 2, "кусок", "куска", "кусков")
  end
  
  def test_propisju_for_floats
    assert_equal "шесть целых пять десятых", RuPropisju.propisju(6.50)
    assert_equal "триста сорок одна целая девять десятых", RuPropisju.propisju(341.9)
    assert_equal "триста сорок одна целая двести сорок пять тысячных", RuPropisju.propisju(341.245)
    assert_equal "двести три целых сорок одна сотая", RuPropisju.propisju(203.41)
    assert_equal "четыреста сорок две целых пять десятых", RuPropisju.propisju(442.50000)
  end
  
  def test_choose_plural
    assert_equal "чемодана", RuPropisju.choose_plural(523, "чемодан", "чемодана", "чемоданов")
    assert_equal "партий", RuPropisju.choose_plural(6727, "партия", "партии", "партий")
    assert_equal "козлов", RuPropisju.choose_plural(45, "козел", "козла", "козлов")
    assert_equal "колес", RuPropisju.choose_plural(260, "колесо", "колеса", "колес")
  end
  
  def test_rublej
    assert_equal "сто двадцать три рубля", RuPropisju.rublej(123)
    assert_equal "триста сорок три рубля 20 копеек", RuPropisju.rublej(343.20)
    assert_equal "42 копейки", RuPropisju.rublej(0.4187)
    assert_equal "триста тридцать два рубля", RuPropisju.rublej(331.995)
    assert_equal "один рубль", RuPropisju.rubl(1)
    assert_equal "три рубля 14 копеек", RuPropisju.rublja(3.14)
  end
  
  def test_griven
    assert_equal "сто двадцать три гривны", RuPropisju.griven(123)
    assert_equal "сто двадцать четыре гривны", RuPropisju.griven(124)
    assert_equal "триста сорок три гривны двадцать копеек", RuPropisju.griven(343.20)
    assert_equal "сорок две копейки", RuPropisju.griven(0.4187)
    assert_equal "триста тридцать две гривны", RuPropisju.griven(331.995)
    assert_equal "одна гривна", RuPropisju.grivna(1)
    assert_equal "три гривны четырнадцать копеек", RuPropisju.grivny(3.14)
  end
  
  def test_kopeek
    assert_equal "сто двадцать три рубля", RuPropisju.kopeek(12300)
    assert_equal "три рубля 14 копеек", RuPropisju.kopeek(314)
    assert_equal "32 копейки", RuPropisju.kopeek(32)
    assert_equal "21 копейка", RuPropisju.kopeika(21)
    assert_equal "3 копейки", RuPropisju.kopeiki(3)
  end
end
