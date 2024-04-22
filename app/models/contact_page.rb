# frozen_string_literal: true

# Create
class ContactPage < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[context created_at id id_value title updated_at]
  end
end
