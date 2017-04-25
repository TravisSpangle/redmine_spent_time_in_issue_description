module TimeEntriesPatch
  module IssuesControllerPatch

    def self.included(base)
      base.class_eval do

        def show_with_plugin
          @journals = @issue.journals.includes(:user, :details).
              references(:user, :details).
              reorder(:created_on, :id).to_a
          @journals.each_with_index { |j, i| j.indice = i+1 }
          @journals.reject!(&:private_notes?) unless User.current.allowed_to?(:view_private_notes, @issue.project)
          Journal.preload_journals_details_custom_fields(@journals)
          @journals.select! { |journal| journal.notes? || journal.visible_details.any? }
          @journals.reverse! if User.current.wants_comments_in_reverse_order?

          @changesets = @issue.changesets.visible.preload(:repository, :user).to_a
          @changesets.reverse! if User.current.wants_comments_in_reverse_order?

          @relations = @issue.relations.select { |r| r.other_issue(@issue) && r.other_issue(@issue).visible? }
          @allowed_statuses = @issue.new_statuses_allowed_to(User.current)
          @priorities = IssuePriority.active
          @time_entry = TimeEntry.new(:issue => @issue, :project => @issue.project)
          @relation = IssueRelation.new

          @time_query = TimeEntryQuery.build_from_params(params)
          scope = time_entry_scope().
              includes(:project, :user, :issue).
              preload(:issue => [:project, :tracker, :status, :assigned_to, :priority])
          @total_hours = scope.sum(:hours).to_f
          @time_entries = scope

          respond_to do |format|
            format.html {
              retrieve_previous_and_next_issue_ids
              render :template => 'issues/show'
            }
            format.api
            format.atom { render :template => 'journals/index', :layout => false, :content_type => 'application/atom+xml' }
            format.pdf {
              send_file_headers! :type => 'application/pdf', :filename => "#{@project.identifier}-#{@issue.id}.pdf"
            }
          end
        end

        alias_method_chain :show, :plugin

        private

        def time_entry_scope(options={})
          scope = @time_query.results_scope(options)
          if @issue
            scope = scope.on_issue(@issue)
          end
          scope
        end

      end
    end
  end
end
