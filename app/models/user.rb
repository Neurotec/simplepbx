class User < ApplicationRecord

  has_many :freeswitches
  belongs_to :user_group

  validates :user_group, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
