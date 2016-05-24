require_relative "../lib/gfa.rb"
require "test/unit"

class TestGFASegmentReferences < Test::Unit::TestCase

  def test_link_other
    l = "L\t1\t+\t2\t-\t*".to_gfa_line
    assert_equal("2", l.other("1"))
    assert_equal("1", l.other("2"))
    assert_raise(RuntimeError){l.other("0")}
  end

  def test_link_orient
    l = "L\t1\t+\t2\t-\t*".to_gfa_line
    assert_equal("+", l.orient("1"))
    assert_equal("-", l.orient("2"))
    assert_raise(RuntimeError){l.orient("0")}
  end

  def test_link_other_orient
    l = "L\t1\t+\t2\t-\t*".to_gfa_line
    assert_equal("-", l.other_orient("1"))
    assert_equal("+", l.other_orient("2"))
    assert_raise(RuntimeError){l.other_orient("0")}
  end

  def test_containment_other
    c = "C\t1\t+\t2\t-\t12\t*".to_gfa_line
    assert_equal("2", c.other("1"))
    assert_equal("1", c.other("2"))
    assert_raise(RuntimeError){c.other("0")}
  end

  def test_containment_orient
    c = "C\t1\t+\t2\t-\t12\t*".to_gfa_line
    assert_equal("+", c.orient("1"))
    assert_equal("-", c.orient("2"))
    assert_raise(RuntimeError){c.orient("0")}
  end

  def test_containment_other_orient
    c = "C\t1\t+\t2\t-\t12\t*".to_gfa_line
    assert_equal("-", c.other_orient("1"))
    assert_equal("+", c.other_orient("2"))
    assert_raise(RuntimeError){c.other_orient("0")}
  end

end