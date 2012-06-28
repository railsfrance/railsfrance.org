FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "john#{n}" }
    password 'johndoe'
    password_confirmation 'johndoe'
    sequence(:email) { |n| "john#{n}@doe.com" }
    sequence(:github) { |n| "john#{n}" }
    sequence(:twitter) { |n| "john#{n}" }
    sequence(:city) { |n| "Paris" }
    sequence(:postal_code) { |n| "75000" }
    sequence(:street) { |n| "Rue Gambetta" }
    after_create { |u| u.confirm! }
  end
end
