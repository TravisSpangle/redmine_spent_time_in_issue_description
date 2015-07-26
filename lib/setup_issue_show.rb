require 'redmine'
require 'fileutils'
require 'pathname_redmine_version'
require 'Digest'

# Identifies correct version of issues/VERSION.show.html.erb and
# copies it to issues/show.html.erb
class SetupIssueShow
  attr_accessor :issues_directory, :current_version, :show_file, :issue_show_file

  def initialize
    plugin_directory = Redmine::Plugin.registered_plugins[:redmine_spent_time_in_issue_description].directory
    @issues_directory =  Pathname.new(plugin_directory).join('app', 'views', 'issues')
    @issue_show_file = @issues_directory.join('show.html.erb').to_s
    @current_version = [Redmine::VERSION::MAJOR, Redmine::VERSION::MINOR, Redmine::VERSION::TINY].join('.')
    set_show_file
  end

  # Location of file to use as Issue#show
  def set_show_file
    possible_files = @issues_directory.children(false).select { |files| files.to_s.index(/\d.*show/) }
    show_file = possible_files.sort { |x, y| y <=> x }.find do |file|
      version = file.to_s[0..4]
      version == @current_version || version < @current_version
    end

    @show_file = @issues_directory.join show_file unless show_file.nil?
  end

  def replace
    FileUtils.copy_file show_file.to_s, issue_show_file
  end

  def replacable?
    File.writable?(show_file.to_s) and Digest::SHA256.file(show_file).hexdigest.eql? Digest::SHA256.file(issue_show_file).hexdigest
  end
end
