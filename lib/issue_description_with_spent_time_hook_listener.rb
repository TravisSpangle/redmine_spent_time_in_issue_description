class IssueDescriptionWithSpentTimeHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, :partial => "spent_time/report"
end

