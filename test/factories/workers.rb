FactoryGirl.define do
  factory :worker do
    sequence(:name) { |n| "Entreprise #{n}" }
    website 'http://www.google.fr'
    street 'rue Gambetta'
    postal_code '75020'
    city 'Paris'
  end
end
