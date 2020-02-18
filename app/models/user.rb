class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :comments
  has_many :answers
  has_many :questions
  
	before_validation :set_default_role

  def name
    email.split('@')[0]
  end

  private
  
  def set_default_role
    self.role ||= Role.find_by_name('user')
  end

end
