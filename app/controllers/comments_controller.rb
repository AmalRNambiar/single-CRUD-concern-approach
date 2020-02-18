class CommentsController < ApplicationController
  before_action :load_comment, only: [:vote]

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def vote
    @comment.send("#{params[:action_name]}_from", current_user)
  end

  private

  def load_comment
    @comment = Comment.find_by_id(params[:comment_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :question_id, :parent_id).merge!(user_id: current_user.id)
  end

end
