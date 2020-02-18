# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'when no user logged in' do
    
    it "should redirect to login page" do
      2.times { create(:option, question: nil) }
      question = create(:question, options: Option.all)
      post :create, params: { comment: { text: Faker::Lorem.question,
                              question_id: question.id } }
      expect(response).to redirect_to new_user_session_path
      expect(response).to have_http_status(:found)
    end
  end

  describe 'when user logged in' do
    let!(:user) { create(:user) }
    
    before :each do
      sign_in(user)
    end

    it "should create a comment when valid attributes are supplied" do      
      2.times { create(:option, question: nil) }
      question = create(:question, options: Option.all)
      post :create, xhr: true, params: { comment: { text: Faker::Lorem.question,
                              question_id: question.id } }
      expect(assigns(:comment).question).to eq question    
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'text/javascript'      
    end

    it "should not create a comment when invalid attributes are supplied" do      
      post :create, xhr: true, params: { comment: { text: nil } }                           
      expect(response).to have_http_status(:ok)
      expect(assigns(:comment).errors.messages).to eq :question=>["must exist"], :text=>["can't be blank"]
    end

    it "should update vote count of comment" do
      2.times { create(:option, question: nil) }
      question = create(:question, options: Option.all)
      comment = create(:comment, question: question)
      expect(comment.get_upvotes.size).to eq 0   
      expect(comment.get_downvotes.size).to eq 0    
      get :vote, xhr: true, params: { action_name: 'upvote', comment_id: comment.id }
      expect(response).to have_http_status(:ok)
      expect(comment.get_upvotes.size).to eq 1    
      expect(comment.get_downvotes.size).to eq 0    
      get :vote, xhr: true, params: { action_name: 'downvote', comment_id: comment.id }
      expect(response).to have_http_status(:ok)
      expect(comment.get_upvotes.size).to eq 0   
      expect(comment.get_downvotes.size).to eq 1 
    end
    
  end
end
