class Users::ShowPresenter
  LIMIT = 3

  def initialize(user)
    @user = user
  end

  def recent_questions
    @recent_questions ||= @user.questions.limit(LIMIT)
  end

  def recent_answers
    @recent_answers ||= @user.answers.limit(LIMIT)
  end
end
