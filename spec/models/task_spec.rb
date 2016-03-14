require 'spec_helper'

describe Task do
	describe "done_regsitration method" do
		before do
			@task = Task.create(user_id: 1, name: "test", urgency: 0, importance: 0, status: 0)
		end
		it "Done registration" do
			@task.done!
			expect(@task.status).to eq 2
		end
	end
end



