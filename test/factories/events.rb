FactoryGirl.define do
  factory :event do
    association :user
    sequence(:title) { |n| "RailsFrance event#{n}" }
    sequence(:description) { |n| "Apero#{n}" }
    sequence(:city) { |n| "Paris" }
    sequence(:postal_code) { |n| "75000" }
    sequence(:street) { |n| "Rue Gambetta" }
    sequence(:date) { |n| "2042-01-01 00:42:42" }
    sequence(:website) { |n| "http://railsfrance.org" }
  end
end
