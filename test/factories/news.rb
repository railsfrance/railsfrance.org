Factory.define :news do |n|
  n.association :user
  n.sequence(:title) { |n| "News#{n}"}
  n.sequence(:description) { |n| "News#{n}"}
end
