class AddDefaultValueToBulletinState < ActiveRecord::Migration[7.1]
  def change
    change_column_default :bulletins, :state, 'draft'
    change_column_null :bulletins, :state, false
  end
end
