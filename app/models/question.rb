class Question < ApplicationRecord
	validates_presence_of :text, :options
	has_many :options, inverse_of: :question
	has_many :comments
	has_many :answers
	belongs_to :user
	accepts_nested_attributes_for :options, allow_destroy: true

	def comments_count
		comments.where(ancestry: nil).count
	end

	def user_answered?(user_id, option_id)
		answers.exists?(user_id: user_id, option_id: option_id)
	end
end
