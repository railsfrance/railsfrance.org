ActiveAdmin::Dashboards.build do
  section 'Last Jobs' do
    table_for Job.order('created_at desc').limit(5) do
      column :title do |job|
        link_to job.title, admin_job_path(job)
      end
      column :email
    end
  end

  section 'Last Events' do
    table_for Event.order('created_at desc').limit(5) do
      column :title do |event|
        link_to event.title, admin_event_path(event)
      end
      column :user
    end
  end

  section 'Last Questions' do
    table_for Question.order('created_at desc').limit(5) do
      column :title do |question|
        link_to question.title, admin_question_path(question)
      end
      column :user
    end
  end

  section 'Last Users' do
    table_for User.order('created_at desc').limit(5) do
      column :username do |user|
        link_to user.username, admin_user_path(user)
      end
      column :email
    end
  end

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
