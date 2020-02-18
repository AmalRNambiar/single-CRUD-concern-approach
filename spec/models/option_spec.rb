# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Option, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:option)).to be_valid
  end

  it 'is invalid without name' do
    expect(build(:option, name: nil)).not_to be_valid
  end

  it "correctly return associated question and answers" do
  	option = create(:option, question: nil)
  	question = create(:question, options: Option.all)
  	option.update(question_id: question.id)
  	answer = create(:answer, question_id: question.id, option_id: option.id)
    expect(option.question).to eq question
    expect(option.answers).to eq [answer]
  end
end
