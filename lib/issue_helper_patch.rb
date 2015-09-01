# Helper Patch to be include in Issue Helper
IssuesHelper.class_eval do
  def humanized_time(entry_hours)
    hours = entry_hours.to_i
    minutes = entry_hours * 60
    minutes = (minutes - hours * 60).to_i

    time_spent = humanized_hour(hours)
    time_spent << ' ' << humanized_minute(minutes) unless minutes < 1

    time_spent
  end

  # Human readable format for Hour data
  def humanized_hour(hours)
    if hours == 1
      t('plugin_spent_time_in_issue.datetime.hours.one')
    elsif hours > 1
      t('plugin_spent_time_in_issue.datetime.hours.other', hours: hours)
    else
      ''
    end
  end

  # Human readable format for Hour minute
  def humanized_minute(minutes)
    if minutes == 1
      ' ' << t('plugin_spent_time_in_issue.datetime.minutes.one')
    elsif minutes > 1
      ' ' << t('plugin_spent_time_in_issue.datetime.minutes.other', minutes: minutes)
    else
      ''
    end
  end

  # Time Spent value in format specified by configuration.
  def report_time_spent(entry)
    if Setting.plugin_redmine_spent_time_in_issue_description['time_format'].eql? 'human'
      humanized_time(entry.hours)
    else
      entry.hours
    end
  end

  def report_time_shown?
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'hours'
  end

  def spent_on_shown?
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'spentOn'
  end

  def user_shown?
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'user'
  end

  def comment_shown?
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'comments'
  end

  def activity_shown?
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'activity'
  end
end
