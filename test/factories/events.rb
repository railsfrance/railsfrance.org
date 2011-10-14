Factory.define :event do |e|
  e.association :user
  e.sequence(:title) { |n| "RailsFrance event#{n}" }
  e.sequence(:description) { |n| "Apero#{n}" }
  e.sequence(:city) { |n| "Paris" }
  e.sequence(:postal_code) { |n| "75000" }
  e.sequence(:street) { |n| "Rue Gambetta" }
  e.sequence(:date) { |n| "2042-01-01 00:42:42" }
  e.sequence(:website) { |n| "http://railsfrance.org" }
end
