# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:comment)).to be_valid
  end

  it 'is invalid without text, user, question' do
    expect(build(:comment, text: nil)).not_to be_valid
    expect(build(:comment, user: nil)).not_to be_valid
    expect(build(:comment, question: nil)).not_to be_valid
  end

  it "correctly return comment is a reply or not" do
  	option = create(:option, question: nil)
  	question = create(:question, options: Option.all)
  	comment = create(:comment, question: question)
  	reply = create(:comment, ancestry: comment.id, question: question)
  	expect(comment.is_reply?).not_to be_truthy
  	expect(reply.is_reply?).to be_truthy
  end

  it 'correctly return user, question' do
    create(:option, question: nil)
    user = create(:user)
    question = create(:question, options: Option.all)
    comment = create(:comment, question: question, user: user)
    expect(comment.question).to eq question
    expect(comment.user).to eq user
  end
end
