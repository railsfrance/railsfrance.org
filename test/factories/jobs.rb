Factory.define :job do |j|
  j.company "p3on.fr"
  j.email "pi3r@p3on.fr"
  j.sequence(:title)   {|n| "Title #{n} #{SecureRandom.hex(10)}" }
  j.cdi true
  j.street "19 rue de Chartres"
  j.token SecureRandom.hex(13)
  j.city "Paris" # Hell Yeah !
  j.postal_code "75018"
  j.description "80k"
end
