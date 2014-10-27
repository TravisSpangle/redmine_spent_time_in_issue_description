class IssueDescriptionWithSpentTimeHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, :partial => "spent_time/report"
  render_on :view_layouts_base_html_head, :partial => "spent_time/javascript_report"
end

