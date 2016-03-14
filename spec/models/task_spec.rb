require 'rails_helper'

describe Task do
	before do
			@user = User.create(email: "test@test.com", password: "password")
			@task1 = Task.create(user_id: @user.id, name: "test", urgency: 0, importance: 0, status: 0)
			@task2 = Task.create(user_id: @user.id, name: "test", urgency: 0, importance: 0, status: 0)
			@task3 = Task.create(user_id: @user.id, name: "test", urgency: 0, importance: 0, status: 0)
	end

	describe "#done_regsitration" do
		it "タスクを完了登録すること" do
			@task1.done!
			expect(@task1.done?).to be true
		end
	end

	describe "#done_multiple"
		it "3つのタスクを完了登録すること" do
			Task.done_multiple(@user, [@task1.id, @task2.id, @task3.id])
			expect(@task1.reload.done?).to be true
			expect(@task2.reload.done?).to be true
			expect(@task3.reload.done?).to be true
		end

		it "3つのタスクのうち,2番めに無効な値を入れてトランザクションさせること" do
			@task2.id=0
			expect{Task.done_multiple(@user, [@task1.id, @task2.id, @task3.id])}.to raise_error
			expect(@task1.reload.done?).to be false
			expect(@task3.reload.done?).to be false
		end
	end



