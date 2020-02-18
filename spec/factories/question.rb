FactoryBot.define do
  factory :question do |f|
  	user
  	f.text { "Example question?" }
  end
end