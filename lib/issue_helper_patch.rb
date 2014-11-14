module IssuesHelperPatch
  module InstanceMethods

    def humanized_time(entry_hours)
      hours = entry_hours.to_i
      minutes = entry_hours * 60
      minutes = (minutes - hours * 60 ).to_i

      time_spent = case
      when hours == 1
        t('plugin_spent_time_in_issue.datetime.hours.one')
      when hours > 1
        t('plugin_spent_time_in_issue.datetime.hours.other', hours: hours)
      else
        ""
      end

      if minutes == 1
        time_spent << " " << t('plugin_spent_time_in_issue.datetime.minutes.one')
      elsif minutes > 1
        time_spent << " " << t('plugin_spent_time_in_issue.datetime.minutes.other', minutes: minutes)
      else
        time_spent
      end
    end

  end

  def report_time_spent(entry)
    if Setting.plugin_redmine_spent_time_in_issue_description['time_format'].eql? "human"
      time_spent = humanized_time( entry.hours )
    else
      time_spent = entry.hours
    end
  end

  def is_report_time_shown( entry )
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'hours'
  end

  def is_spent_on_shown( entry )
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'spentOn'
  end

  def is_user_shown( entry )
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'user'
  end

  def is_comment_shown( entry )
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'comments'
  end

  def is_activity_shown( entry )
    Setting.plugin_redmine_spent_time_in_issue_description['display_columns'].include? 'activity'
  end

  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end

