class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
    	t.references :user, null: false
    	t.references :group, null: false
    	t.integer :role, null: false, default: 0

      t.timestamps null: false
    end
  end
end
