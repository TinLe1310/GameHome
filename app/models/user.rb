# frozen_string_literal: true

# Create
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart
  validates :user_name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at user_name email id password updated_at]
  end
end
