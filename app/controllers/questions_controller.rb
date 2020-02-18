class QuestionsController < ApplicationController
	include CrudConcern
	before_action :initialize_form, only: [:index]

	def new
		super
		2.times { @question.options.build }
	end

	private

	def question_params
    params.require(:question).permit(:text, options_attributes: [:id, :name]).merge!(user_id: current_user.id)
  end

  def initialize_form
  	@comment = Comment.new
		@answer = Answer.new
  end
end
