FactoryGirl.define do
  factory :guide do
    sequence(:name) { |n| "Guide #{n}" }
    sequence(:description) { |n| "A guide to start Rails#{n}" }
    website 'http://guides.rubyonrails.org'
  end
end
