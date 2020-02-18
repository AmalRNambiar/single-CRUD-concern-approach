# frozen_string_literal: true
require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'when no user logged in' do
    it "should redirect to login page" do
      get :new
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should redirect to login page" do
      post :create, params: { question: { text: Faker::Lorem.question,
                              options_attributes: {"0"=>{"name"=>"aaaf", "_destroy"=>"false"},
                                                   "1"=>{"name"=>"afaf", "_destroy"=>"false"}}} }
      expect(response).to redirect_to new_user_session_path
      expect(response).to have_http_status(:found)
    end
  end

  describe 'when user logged in' do
    let!(:user) { create(:user) }
    
    before :each do
      sign_in(user)
    end

    it "should render new page" do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(:ok)
    end
    
    it "should create a question" do      
      post :create, params: { question: { text: Faker::Lorem.question,
                              options_attributes: {"0"=>{"name"=>"aaaf", "_destroy"=>"false"},
                             "1"=>{"name"=>"afaf", "_destroy"=>"false"}}} }                       
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path  
    end

    it "should not create a question" do      
      post :create, params: { question: { text: Faker::Lorem.question } }                           
      expect(response).to have_http_status(:found)
      expect(assigns(:question).errors.messages).to eq :options => ["can't be blank"]
      expect(response).to redirect_to new_question_path
    end
  end
end
