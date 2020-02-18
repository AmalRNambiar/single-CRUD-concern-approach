FactoryBot.define do
  factory :option do |f|
  	question
  	f.sequence (:name) { |n| "option-#{n}" }
  end
end