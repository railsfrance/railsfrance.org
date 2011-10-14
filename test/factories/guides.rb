Factory.define :guide do |g|
  g.sequence(:name) { |n| "Guide #{n}" }
  g.sequence(:description) { |n| "A guide to start Rails#{n}" }
  g.website 'http://guides.rubyonrails.org'
end
