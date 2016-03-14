require 'rails_helper'

describe Task do
	describe "#done_regsitration" do
		before do
			@user = User.create(email: "test@test.com", password: "password")
			@task1 = Task.create(user_id: @user.id, name: "test", urgency: 0, importance: 0, status: 0)
			@task2 = Task.create(user_id: @user.id, name: "test", urgency: 0, importance: 0, status: 0)
			@task3 = Task.create(user_id: @user.id, name: "test", urgency: 0, importance: 0, status: 0)
		end

		it "Done registration" do
			@task1.done!
			expect(@task1.done?).to be true
		end

		it "#done_multiple" do
			Task.done_multiple(@user, [@task1.id, @task2.id, @task3.id])
			expect(@task1.done? && @task2.done? && @task3.done?).to be true
		end

		it "#done_multiple(2nd data is invalid)" do
			@task2.name=""
			Task.done_multiple(@user, [@task1.id, @task2.id, @task3.id])
			expect(@task1.done? || @task2.done? || @task3.done?).to be false
		end
	end
end



