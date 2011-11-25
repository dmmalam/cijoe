require 'helper'

class TestCIJoeQueue < MiniTest::Unit::TestCase
  def test_empty_queue
    subject = CIJoe::Queue.new
    assert_equal false, subject.waiting?
  end

  def test_a_disable_queue_append
    subject = CIJoe::Queue.new
    assert_nil subject.append_unless_already_exists("joe")
  end

  def test_a_disabled_queue_waiting
    subject = CIJoe::Queue.new(false)
    assert_equal false, subject.waiting?
  end

  def test_a_diable_queue_shift
    subject = CIJoe::Queue.new(false)
    assert_equal nil, subject.next_branch_to_build
  end

  def test_waiting_two_items_in_a_queue
    subject = CIJoe::Queue.new(true)
    subject.append_unless_already_exists("foo")
    subject.append_unless_already_exists("bar")

    assert_equal true, subject.waiting?
    foo = subject.next_branch_to_build
    bar = subject.next_branch_to_build
    assert_equal false, subject.waiting?
  end

  def test_shift_two_items_in_a_queue
    subject = CIJoe::Queue.new(true)
    subject.append_unless_already_exists("foo")
    subject.append_unless_already_exists("bar")

    assert_equal "foo", subject.next_branch_to_build
    assert_equal "bar", subject.next_branch_to_build
  end

  def test_waiting_two_duplicate_items_in_a_queue
    subject = CIJoe::Queue.new(true)
    subject.append_unless_already_exists("foo")
    subject.append_unless_already_exists("foo")

    assert_equal true, subject.waiting?
    foo = subject.next_branch_to_build
    assert_equal false, subject.waiting?
  end

  def test_shift_two_duplicate_items_in_a_queue
    subject = CIJoe::Queue.new(true)
    subject.append_unless_already_exists("foo")
    subject.append_unless_already_exists("foo")

    assert_equal "foo", subject.next_branch_to_build
    assert_nil subject.next_branch_to_build
  end


  def test_shift_two_duplicate_with_whitespace_in_a_queue
    subject = CIJoe::Queue.new(true)
    subject.append_unless_already_exists("foo")
    subject.append_unless_already_exists("  foo  ")

    assert_equal "foo", subject.next_branch_to_build
    assert_nil subject.next_branch_to_build
  end
end
