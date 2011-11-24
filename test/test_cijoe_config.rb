require 'helper'

class TestCIJoe < MiniTest::Unit::TestCase
  def test_raise_error_on_invalid_command
    assert_raises RuntimeError, LoadError do
      CIJoe::Config.new('--invalid').to_s
    end
  end

  def test_return_value_of_config
    assert_equal `git config blame.yourself`.chomp, CIJoe::Config.new(:blame).yourself.to_s
  end

  def test_return_empty_string_when_config_does_not_exist
    assert_equal '', CIJoe::Config.invalid.invalid.to_s
  end
end
