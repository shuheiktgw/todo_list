require 'rails_helper'

describe Task do
		let(:user)  {create(:user)}
		let(:task1) {create(:task)}
		let(:task2) {create(:task)}
		let(:task3) {create(:task)}

	describe "#done_regsitration" do
		let(:task1) {create(:task)}

		it "タスクを完了登録すること" do
			task1.done!
			expect(task1.done?).to be true
		end
	end

	describe "#done_multiple" do

		it "成功すればすべて完了になる" do
			Task.done_multiple(user, [task1.id, task2.id, task3.id])
			expect(task1.reload.done?).to be true
			expect(task2.reload.done?).to be true
			expect(task3.reload.done?).to be true
		end

		it "どれかが失敗するとすべてのステータスが変更されない" do
			expect{Task.done_multiple(user, [task1.id, 0, task3.id])}.to raise_error
			expect(task1.reload.not_yet?).to be true
			expect(task3.reload.not_yet?).to be true
		end
	end
end



