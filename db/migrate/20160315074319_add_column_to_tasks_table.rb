class AddColumnToTasksTable < ActiveRecord::Migration
  def change
  	add_reference :tasks, :group, index: true
  end
end
