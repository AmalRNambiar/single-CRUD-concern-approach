class Comment < ApplicationRecord
	belongs_to :question
	belongs_to :user
	has_ancestry
	acts_as_votable
	
	validates_presence_of :text

	def is_reply?
		ancestry != nil
	end
	
end
