class Option < ApplicationRecord
	belongs_to :question, optional: true
	validates_presence_of :name
	has_many :answers
end
