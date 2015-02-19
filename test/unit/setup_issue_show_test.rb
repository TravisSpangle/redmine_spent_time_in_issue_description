require File.expand_path('../../test_helper', __FILE__)

# Testing process matches and updates issues/show
class SetupIssueShowTest < ActiveSupport::TestCase
  def setup
    @setup_issue_show = SetupIssueShow.new
  end

  def test_start
    assert_equal 'test', 'test'
  end

  def test_version_detection
    assert_equal @setup_issue_show.current_version.class, String
    assert_not_nil @setup_issue_show.current_version[/\d+\.\d+\.\d+/]
  end

  def test_show_file
    assert_equal @setup_issue_show.show_file.class, Pathname
  end

  def test_correct_file_found
    @setup_issue_show.current_version = '2.3.1'
    assert_equal '2.3.1', @setup_issue_show.show_file.redmine_version, 'Did not find the exact match.'

    @setup_issue_show.current_version = '2.3.2'
    assert_equal '2.3.1', @setup_issue_show.show_file.redmine_version, 'Did not find the most recent match.'

    @setup_issue_show.current_version = '0.0.0'
    assert_nil @setup_issue_show.show_file
  end
end
