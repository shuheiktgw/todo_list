class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.references :user, null: false
    	t.string :name, null: false
    	t.integer :urgency, null: false, default: 0
    	t.integer :importance, null: false, default: 0
    	t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
