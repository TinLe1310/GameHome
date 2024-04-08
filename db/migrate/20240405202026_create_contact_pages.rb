class CreateContactPages < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_pages do |t|
      t.string :title
      t.string :context

      t.timestamps
    end
  end
end
