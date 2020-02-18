require 'faker'
['user', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end
admin_role = Role.find_by_name('admin')
User.create(email: 'user@example.com', password: '123456') unless User.exists?(email: 'user@example.com')

def create_options
  4.times do
    Option.create(
      name: Faker::Color.color_name,
    )
  end
  Option.where(question_id: nil)
end

5.times do
  user = User.create(
    email: Faker::Internet.email,
    password:  Faker::Internet.password
  )
  options = create_options
  question = Question.create(
      text: Faker::Lorem.question,
      options: options,
      user: user
    )
  options.update(question_id: question.id)    
  comment = Comment.create(
    question: question,
    user: user,
    text: Faker::Movie.quote
  )
  reply = Comment.create(
    question: question,
    user: user,
    text: Faker::Movie.quote,
    ancestry: comment.id
  )
end
