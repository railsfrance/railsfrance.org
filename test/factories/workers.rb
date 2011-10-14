Factory.define :worker do |w|
  w.sequence(:name) { |n| "Entreprise #{n}" }
  w.website 'http://www.google.fr'
  w.street 'rue Gambetta'
  w.postal_code '75020'
  w.city 'Paris'
end
