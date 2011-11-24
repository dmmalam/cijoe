require 'helper'

# Переместить в фикстуры
#

class TestCIJoeCommit < MiniTest::Unit::TestCase
  def commit_message
    <<END
    commit 291419e3ba46156f09ac31f267e2016640d286f6
    Author: Matt Colyer <matt@smallbatchinc.com>
    Date:   Thu Mar 31 12:45:41 2011 -0700

    foo bar
END
  end

  def setup
    @commit = CIJoe::Commit.new
    @commit.stubs(:raw_commit).returns(commit_message)
  end

  def test_return_author
    assert_equal "Matt Colyer <matt@smallbatchinc.com>", @commit.author
  end

  def test_return_committed_at
    assert_equal  "Thu Mar 31 12:45:41 2011 -0700", @commit.committed_at
  end

  def test_return_message
    assert_equal "foo bar", @commit.message
  end
end
