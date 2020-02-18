FactoryBot.define do
  factory :comment do |f|
  	user
  	question
  	f.text { 'first comment'}
  end
end