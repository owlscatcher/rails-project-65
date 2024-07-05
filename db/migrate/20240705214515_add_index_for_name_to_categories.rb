class AddIndexForNameToCategories < ActiveRecord::Migration[7.1]
  def change
    remove_index :categories, :name
    add_index :categories, :name, unique: true
  end
end
