Factory.define :question do |q|
  q.association :user
  q.sequence(:title) { |n| "RailsFrance question#{n}" }
  q.sequence(:description) { |n| "How does it works ?#{n}" }
  q.tag_list "tag42"
end
