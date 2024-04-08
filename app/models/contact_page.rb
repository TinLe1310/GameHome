class ContactPage < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["context", "created_at", "id", "id_value", "title", "updated_at"]
  end
end
