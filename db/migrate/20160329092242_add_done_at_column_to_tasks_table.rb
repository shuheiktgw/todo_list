class AddDoneAtColumnToTasksTable < ActiveRecord::Migration
  def change
    add_column :tasks, :done_date, :date
  end
end
