# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'is valid with valid attributes' do
  	option = create(:option, question: nil)
  	question = create(:question, options: Option.all)
    expect(build(:answer, question_id: question.id, option_id: option.id)).to be_valid
  end

  it 'is invalid without text, user, question' do
    expect(build(:answer, option: nil)).not_to be_valid
    expect(build(:answer, user: nil)).not_to be_valid
    expect(build(:answer, question: nil)).not_to be_valid
  end

  it "correctly return user, option, question of an answer" do
  	user = create(:user)
  	option = create(:option, question: nil)
  	question = create(:question, options: Option.all)
  	option.update(question_id: question.id)
  	answer = create(:answer, question_id: question.id, option_id: option.id, user_id: user.id)
  	expect(answer.user).to eq user
  	expect(answer.option).to eq option
  	expect(answer.question).to eq question
  end
end
