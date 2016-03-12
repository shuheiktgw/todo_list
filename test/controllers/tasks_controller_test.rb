require 'test_helper'

class TasksControllerTest < ActionController::TestCase

	def setup
		@task = tasks(:test_task)
	end


	test "check done registration" do
		get tasks_path
		assert_difference "Task.done.count", 1 do
			patch done_registration_tasks, checked_id: ["1"]
		end
		assert _redirected_to tasks_url
	end



end
