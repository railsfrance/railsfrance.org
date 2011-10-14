Factory.define :comment_event, :class => Comment do |c|
  c.association :user
  c.association :commentable, :factory => :event
  c.sequence(:description) { |n| "Nice comment !#{n}" }
end

Factory.define :comment_news, :class => Comment do |c|
  c.association :user
  c.association :commentable, :factory => :news
  c.sequence(:description) { |n| "Nice comment !#{n}" }
end
