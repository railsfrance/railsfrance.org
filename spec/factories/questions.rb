FactoryGirl.define do
  factory :question do
    association :user
    sequence(:title) { |n| "RailsFrance question#{n}" }
    sequence(:description) { |n| "How does it works ?#{n}" }
    tag_list "tag42"
  end
end
