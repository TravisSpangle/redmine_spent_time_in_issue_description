require 'redmine'
require 'setup_issue_show'

Redmine::Plugin.register :redmine_spent_time_in_issue_description do
  name 'Issue Description with Spent Time'
  author 'Travis Spangle, @dsatsura, @tbird1965'
  description 'This will feed the spent time into the description of the issue.'
  version '2.8.2'
  url 'https://github.com/TravisSpangle/redmine_spent_time_in_issue_description'
  settings(default: {  'spent_time_max_display'  => 5,
                       'display_columns' => %w(spentOn user hours comments),
                       'time_format' => 'decimal',
                       'report_location' => 'ticket_body'
                    },
           partial: 'settings/spent_time_in_issue_description_settings')

  #to_prepare removed from Rails 5.1
  #ActionDispatch::Callbacks.to_prepare do
  ActiveSupport::Reloader.to_prepare do
    SetupIssueShow.new.replace
  end
  Rails.application.config.after_initialize do
    require 'issue_helper_patch'
  end
end
