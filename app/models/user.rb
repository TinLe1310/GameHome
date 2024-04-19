class User < ApplicationRecord
  has_one :cart
  validates :user_name, :password, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ['created_at', 'user_name', 'email', 'id', 'password','updated_at']
  end
end
