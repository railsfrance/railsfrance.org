Factory.define :answer do |a|
  a.association :user
  a.association :question
  a.sequence(:description) { |n| "Nice answer !#{n}" }
end
