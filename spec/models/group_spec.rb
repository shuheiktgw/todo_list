require 'rails_helper'

describe Group do
	let(:group_params){{name: 'test', description: 'these are params for the test'}}
	let(:user)  {create(:user)}
	let(:other_user)  {create(:user)}

	describe '#self.create_a_new_goup' do
		it 'グループが登録できる' do
			expect(Group.create_a_new_group(group_params, user)).to be_truthy
		end

		it 'グループを作るとgroupsのcreated_byに作成者が登録される' do
			group = Group.create_a_new_group(group_params, user)
			expect(group.created_by).to eq(user.id)
		end

		it 'グループを作ると作成者がメンバーになる' do
			group = Group.create_a_new_group(group_params, user)
			expect(group.group_members.exists?(user_id: user.id)).to be_truthy
		end

		it 'グループを作ると作成者が管理者になる' do
			group = Group.create_a_new_group(group_params, user)
			expect(group.group_members.find_by(user_id: user.id).admin?).to be_truthy
		end
	end

	describe '#admin?' do
		it 'userが管理者ならtrueを返す' do
			group = Group.create_a_new_group(group_params, user)
			expect(group.admin?(user)).to be_truthy
		end

		it 'userが管理者でなければfalseを返す' do
			group = Group.create_a_new_group(group_params, other_user)
			expect(group.admin?(user)).to be_falsey
		end
	end

	describe '#member?' do
		it 'userがメンバーならtrueを返す' do
			group = Group.create_a_new_group(group_params, user)
			other_user.groups << group
			expect(group.member?(other_user)).to be_truthy
		end

		it 'userがメンバーでなければfalseを返す' do
			group = Group.create_a_new_group(group_params, other_user)
			expect(group.member?(user)).to be_falsey
		end
	end

end


