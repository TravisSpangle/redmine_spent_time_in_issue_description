
require 'redmine'

require_dependency 'issue_description_with_spent_time_hook_listener'

Redmine::Plugin.register :redmine_spent_time_in_issue_description do
  name 'Issue Description with Spent Time'
  author 'Travis Spangle'
  description 'This will feed the spent time into the description of the issue.'
  version '0.8'
  url 'https://github.com/TravisSpangle/redmine_spent_time_in_issue_description'
end
