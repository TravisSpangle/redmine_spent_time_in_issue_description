require 'redmine'
require 'fileutils'

class SetupIssueShow
  attr_reader :issues_directoy, :current_version

  def initialize
    @issues_directory =  Pathname.new( Redmine::Plugin.registered_plugins[:redmine_spent_time_in_issue_description].directory ).join("app","views","issues")
    @current_version = [ Redmine::VERSION::MAJOR, Redmine::VERSION::MINOR, Redmine::VERSION::TINY ].join('.')
  end

  def show_file
    possible_files = @issues_directory.children(false).select{ |files| files.to_s.index(/\d.*show/) }
    file = possible_files.sort{|x,y| y <=> x }.find do |file|
      version = file.to_s[0..4]
      version == @current_version || version < @current_version
    end
    @issues_directory.join file
  end

  def replace
    FileUtils.copy_file show_file.to_s, @issues_directory.join('show.html.erb').to_s
  end

end
