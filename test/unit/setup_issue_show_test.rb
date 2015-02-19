require File.expand_path('../../test_helper', __FILE__)

class SetupIssueShowTest < ActiveSupport::TestCase

  def setup
    @SetupIssueShow = SetupIssueShow.new
  end

  def test_start
    assert_equal 'test', 'test'
  end

  def test_version_detection
    assert_equal @SetupIssueShow.current_version.class, String
    assert_not_nil @SetupIssueShow.current_version[/\d+\.\d+\.\d+/]
  end

  def test_show_file
    assert_equal @SetupIssueShow.show_file.class, Pathname
  end

  def test_correct_file_found

    @SetupIssueShow.current_version="2.3.1"
    assert_equal "2.3.1", @SetupIssueShow.show_file.redmine_version, "Did not find the exact match."

    @SetupIssueShow.current_version="2.3.2"
    assert_equal "2.3.1", @SetupIssueShow.show_file.redmine_version, "Did not find the most recent match."

    @SetupIssueShow.current_version="0.0.0"
    assert_nil @SetupIssueShow.show_file

  end

end
