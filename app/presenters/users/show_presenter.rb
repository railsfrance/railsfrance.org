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

  memoize :recent_questions, :recent_answers
end
