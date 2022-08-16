class AddOwnerToGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :groups, :owner, null: false, foreign_key: { to_table: :users }
  end
end
