class AnswersController < ApplicationController
	include CrudConcern

	private

	def answer_params
    params.require(:answer).permit(:question_id, :option_id).merge!(user_id: current_user.id)
  end

end