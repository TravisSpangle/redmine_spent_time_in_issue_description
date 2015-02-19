require 'redmine'
require 'fileutils'
require 'pathname_redmine_version'

class SetupIssueShow
  attr_accessor :issues_directory
  attr_accessor :current_version

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

    show_file = @issues_directory.join file unless file.nil?

  end

  def replace
    FileUtils.copy_file show_file.to_s, @issues_directory.join('show.html.erb').to_s
  end

end
