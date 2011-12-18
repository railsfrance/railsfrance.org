class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can :create, :all
    can :update, :all do |i|
      i.try(:user) == user
    end
    can :vote, :all do |i|
      i.voteable_by? user
    end
    can :accept, :all do |i|
      i.accepteable_by? user
    end
  end
end
