# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'when no user logged in' do  
    it "should redirect to login page" do
      post :create, params: { answer: { option_id: nil, question_id: nil} }
      expect(response).to redirect_to new_user_session_path
      expect(response).to have_http_status(:found)
    end
  end

  describe 'when user logged in' do
    let!(:user) { create(:user) }
    
    before :each do
      sign_in(user)
    end

    it "should create a answer" do
      2.times { create(:option, question: nil) }
      question = create(:question, options: Option.all)   
      post :create, params: { answer: { option_id: Option.first.id,
                              question_id: question.id } }
      expect(assigns(:answer).question).to eq question
      expect(assigns(:answer).option).to eq Option.first                    
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path  
    end

    it "should not create a answer" do      
      post :create, params: { answer: { option_id: nil, question_id: nil} }                           
      expect(response).to have_http_status(:found)
      expect(assigns(:answer).errors.messages).to eq :option => ["must exist"], :question => ["must exist"]
    end
  end
end
