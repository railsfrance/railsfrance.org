class Question < ActiveRecord::Base
  include Voteable
  include Hiteable
  extend FriendlyId
  extend Sortable

  belongs_to :user, :counter_cache => :questions_count
  has_many :answers, :dependent => :destroy
  belongs_to :accepted_answer, :class_name => 'Answer', :foreign_key => :accepted_answer_id

  friendly_id :title, :use => :slugged
  paginates_per 10

  delegate :page, :to => :answers, :prefix => true, :allow_nil => true
  delegate :username, :to => :user, :prefix => true, :allow_nil => true

  attr_accessible :title, :description, :tag_list

  validates_presence_of :user, :description
  validates :title, :presence => true, :length => { :maximum => 100 }
  validate :max_tags

  make_voteable
  acts_as_taggable

  attr_sortable :created_at, :up_votes, :answers_count

  def self.sortable?(sort)
    self.attr_sortable.include?(sort.try(:to_sym)) ? true : false
  end

  def self.with_tag(tag)
    tag.nil? ? self : tagged_with(tag)
  end

  private

  def max_tags
    self.errors.add(:tag_list, "Maximum 5 tags !") unless
      self.tag_list_cache_on('tags').uniq.length < 5
  end
end
