class AddDescriptionColumnToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :description, :text
  end
end
