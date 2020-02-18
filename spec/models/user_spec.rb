# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without role, email or password' do
    expect(build(:user, email: nil)).not_to be_valid
    expect(build(:user, email: 'invalid-email')).not_to be_valid
    expect(build(:user, password: nil)).not_to be_valid
  end

  it 'correctly returns user name from email' do
    user = create(:user, email: 'amalrnambiarlive@gmail.com')
    expect(user.name).to eq 'amalrnambiarlive'
  end

  it "should not allow two users with same email address" do
  	create(:user, email: 'user@example.com')
    expect(build(:user, email: 'user@example.com')).not_to be_valid
  end

  it "automatically sets user role if no role is given" do
  	user_role = create(:role, name: 'user')
  	expect(build(:user, role: nil)).to be_valid
  	expect(create(:user, role: nil).role).to eq user_role
  end

  it "correctly return associated role, comments, answers" do
  	user_role = create(:role, name: 'user')
  	user = create(:user, role: user_role)
  	option = create(:option, question: nil)
  	question = create(:question, options: Option.all, user: user)
  	option.update(question_id: question.id)
  	answer = create(:answer, question_id: question.id, option_id: option.id, user_id: user.id)
  	comment = create(:comment, question: question, user: user)
  	expect(user.comments).to eq [comment]
  	expect(user.answers).to eq [answer]
  	expect(user.questions).to eq [question]
  	expect(user.role).to eq user_role
  end
end