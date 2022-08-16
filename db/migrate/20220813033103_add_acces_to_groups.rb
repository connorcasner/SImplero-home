class AddAccesToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :access, :integer, default: 0
    add_index :groups, :access
  end
end
