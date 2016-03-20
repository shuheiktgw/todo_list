require 'rails_helper'

describe Group do
	let(:user)  {create(:user)}
	let(:other_user)  {create(:user)}
	let(:group) {build(:group)}

	describe '#self.create_a_new_goup' do
		it 'グループが登録できる' do
			expect(Group.create_a_new_group(group, user)).to be_truthy
		end

		it 'グループを作るとgroupsのcreated_byに作成者が登録される' do
			Group.create_a_new_group(group, user)
			expect(group.created_by).to eq(user.id)
		end

		it 'グループを作ると作成者がメンバーになる' do
			Group.create_a_new_group(group, user)
			expect(group.group_members.exists?(user_id: user.id)).to be_truthy
		end

		it 'グループを作ると作成者が管理者になる' do
			Group.create_a_new_group(group, user)
			expect(group.group_members.find_by(user_id: user.id).admin?).to be_truthy
		end
	end

	describe '#admin?' do
		it 'userが管理者ならtrueを返す' do
			Group.create_a_new_group(group, user)
			expect(group.admin?(user)).to be_truthy
		end

		it 'userが管理者でなければfalseを返す' do
			Group.create_a_new_group(group, other_user)
			expect(group.admin?(user)).to be_falsey
		end
	end

	describe '#member?' do
		it 'userがメンバーならtrueを返す' do
			Group.create_a_new_group(group, user)
			expect(group.member?(user)).to be_truthy
		end

		it 'userがメンバーでなければfalseを返す' do
			Group.create_a_new_group(group, other_user)
			expect(group.member?(user)).to be_falsey
		end
	end

end


