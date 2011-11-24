require 'helper'

class TestCiJoeBuid < MiniTest::Unit::TestCase
  attr_accessor :build

  def setup
    # Struct.new(:project_path, :user, :project, :started_at, :finished_at, :sha, :status, :output, :pid, :branch)
    @build = CIJoe::Build.new(
      "path",                                     # project_path
      "joe",                                      # user
      "cijoe",                                    # project
      Time.now,                                   # started_at
      Time.now + 42,                              # finished_at
      "61595924635744d83cee146c7abe7cb3a2bd2755") # sha
  end

  def test_new_build
    build = CIJoe::Build.new
    assert nil != build.started_at
  end

  def test_nil_status
    assert_nil build.status
  end

  def test_succes_status
    build.status = :success
    assert_equal :success, build.status
  end

  def test_building_status
    build.status = nil
    build.finished_at = nil
    assert_equal :building, build.status
  end

  def test_duration
    assert_equal 42, build.duration.to_i
  end
end
