class Answer < ActiveRecord::Base
  include Voteable

  belongs_to :user, :counter_cache => :answers_count
  belongs_to :question, :counter_cache => :answers_count

  paginates_per 5
  make_voteable

  delegate :user, :to => :question, :prefix => true, :allow_nil => true
  delegate :username, :to => :user, :prefix => true, :allow_nil => true
  delegate :accepted_answer, :to => :question, :prefix => true, :allow_nil => true
  delegate :title, :to => :question, :prefix => true, :allow_nil => true

  attr_accessible :question, :description

  validates_presence_of :user, :question, :description

  def accepteable_by?(user)
    (user == self.question_user) && (user != self.user) && self.question_accepted_answer.nil?
  end
end
