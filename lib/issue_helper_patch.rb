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

  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end

