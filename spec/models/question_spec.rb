# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'is valid with valid attributes' do
    4.times { create(:option, question: nil) }
    expect(build(:question, options: Option.all)).to be_valid
  end

  it 'is invalid without text, options' do
    expect(build(:question, text: nil, options: [])).not_to be_valid
    expect(build(:question, options: [])).not_to be_valid
  end

  it "correctly return comment count" do
  	4.times { create(:option, question: nil) }
  	question = create(:question, options: Option.all)
  	4.times { create(:comment, question: question) }
  	expect(question.comments_count).to eq 4
  end

  it "correctly returns user question answered or not" do
  	user = create(:user)
  	option = create(:option, question: nil)
  	question = create(:question, options: Option.all)
  	option.update(question_id: question.id)
  	create(:answer, question_id: question.id, option_id: option.id)
  	expect(question.user_answered?(user.id, option.id)).not_to be_truthy 
  	create(:answer, question_id: question.id, option_id: option.id, user: user)
  	expect(question.user_answered?(user.id, option.id)).to be_truthy 
  end

  it "correctly return associated comments, answers, options" do
  	user = create(:user)
  	option = create(:option, question: nil)
  	question = create(:question, options: Option.all, user: user)
  	option.update(question_id: question.id)
  	answer = create(:answer, question_id: question.id, option_id: option.id)
  	comment = create(:comment, question: question, user: user)
  	expect(question.comments).to eq [comment]
  	expect(question.answers).to eq [answer]
  	expect(question.options).to eq [option]
  	expect(question.user).to eq user
  end
end
