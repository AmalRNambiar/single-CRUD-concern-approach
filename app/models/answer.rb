class Answer < ApplicationRecord
	belongs_to :user
	belongs_to :question
	belongs_to :option

	after_create :update_progress
	
	private

	def update_progress
		question.update(progress: option.progress+1)
		option.update(progress: option.progress+1)
	end
	
end
