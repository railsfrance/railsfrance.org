class Comment < ActiveRecord::Base
  default_scope :order => 'created_at ASC'

  belongs_to :user
  belongs_to :commentable, :polymorphic => true, :counter_cache => :comments_count

  paginates_per 5

  attr_protected :user

  validates_presence_of :user, :commentable, :description

  delegate :username, :to => :user, :prefix => true, :allow_nil => true
  delegate :gravatar_url, :to => :user, :prefix => true, :allow_nil => true
end
