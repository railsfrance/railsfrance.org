FactoryGirl.define do
  factory :answer do
    association :user
    association :question
    sequence(:description) { |n| "Nice answer !#{n}" }
  end
end
