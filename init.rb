require 'redmine'
require 'issue_helper_patch'
require 'setup_issue_show'

Redmine::Plugin.register :redmine_spent_time_in_issue_description do
  name 'Issue Description with Spent Time'
  author 'Travis Spangle'
  description 'This will feed the spent time into the description of the issue.'
  version '2.5'
  url 'https://github.com/TravisSpangle/redmine_spent_time_in_issue_description'
  settings(default: {  'spent_time_max_display'  => 5,
                       'display_columns' => %w('spentOn', 'user', 'hours', 'comments'),
                       'time_format' => 'decimal',
                       'report_location' => 'ticket_body'
                    },
           partial: 'settings/spent_time_settings')

  ActionDispatch::Callbacks.to_prepare do
    SetupIssueShow.new.replace
  end
end
