class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart
  validates :user_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ['created_at', 'user_name', 'email', 'id', 'password','updated_at']
  end
end
