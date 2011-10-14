class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Moderator
    if user.role?('moderator')
      can :manage, Question
      can :manage, Comment
      can :manage, Answer
      can :manage, Event
      can :manage, Job
      can :manage, Worker
      can :manage, Guide
    end

    # Administrator
    if user.role?('administrator')
      can :manage, User
    end
  end
end
