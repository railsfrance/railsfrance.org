class Users::ShowPresenter
  extend ActiveSupport::Memoizable
  LIMIT = 3

  def initialize(user)
    @user = user
  end

  def recent_questions
    @user.questions.limit(LIMIT)
  end

  def recent_answers
    @user.answers.limit(LIMIT)
  end

  def recent_attended_events
    Event.joins(:event_attendees).where(:event_attendees => { :user_id => @user.id} ).limit(LIMIT)
  end

  def recent_created_events
    @user.events.limit(LIMIT)
  end

  def total_questions
  end

  def total_answers
  end

  memoize :recent_questions, :recent_answers, :recent_attended_events, :recent_created_events
end
