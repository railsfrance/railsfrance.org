FactoryGirl.define do
  factory :job do
    company "p3on.fr"
    email "pi3r@p3on.fr"
    sequence(:title)   {|n| "Title #{n} #{SecureRandom.hex(10)}" }
    cdi true
    street "19 rue de Chartres"
    token SecureRandom.hex(13)
    city "Paris" # Hell Yeah !
    postal_code "75018"
    description "80k"
  end
end
