class AddIndexUniquenessToGroupMembres < ActiveRecord::Migration
  def change
  	add_index :group_members, [:user_id, :group_id], :unique => true
  end
end
