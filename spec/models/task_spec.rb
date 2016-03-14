require 'rails_helper'

describe Task do
	describe "#done_regsitration" do
		before do
			@user = User.create(email: "test@test.com", password: "password")
			@task = Task.create(user_id: @user.id, name: "test", urgency: 0, importance: 0, status: 0)
		end
		it "Done registration" do
			@task.done!
			expect(@task.status).to eq "done"
		end

		it "#done_multiple" do
			Task.done_multiple(@user, [@task.id])
			expect(@task.status).to eq "done"
		end
	end
end



