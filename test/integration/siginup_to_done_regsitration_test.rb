require 'test_helper'

class SiginupToDoneRegsitrationTest < ActionDispatch::IntegrationTest
	test "sign_up to done registration" do
		assert_difference "User.count", 1 do
			post_via_redirect user_registration_path, user: {id: 1, email: "example@example.com",
				password: "password", password_confirmation: "password", }
		end

		assert_template 'tasks/index'
		assert_difference "Task.count", 1 do
			post_via_redirect tasks_path, task: {name: "test", description: "testtest",
				urgency: "urgency_low", importance: "importance_low", status: "not_yet"}
		end
		assert_difference "Task.done.count", 1 do
			patch done_registration_tasks_path checked_id: ["1"]
		end
	end

end
