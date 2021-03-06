require 'rails_helper'

describe Group do
	let(:group_params){{name: 'test', description: 'these are params for the test'}}
	let(:user)  {create(:user)}
	let(:other_user)  {create(:user)}
	let(:user_group){Group.create_a_new_group(group_params, user)}
	let(:other_user_group){Group.create_a_new_group(group_params, other_user)}

	describe '.create_a_new_goup' do
		it 'グループが登録できる' do
			expect(Group.create_a_new_group(group_params, user)).to be_truthy
		end

		it 'グループを作るとgroupsのcreated_byに作成者が登録される' do
			expect(user_group.created_by).to eq(user.id)
		end

		it 'グループを作ると作成者がメンバーになる' do
			expect(user_group.group_members.exists?(user_id: user.id)).to be_truthy
		end

		it 'グループを作ると作成者が管理者になる' do
			expect(user_group.group_members.find_by(user_id: user.id).admin?).to be_truthy
		end

		it "グループのバリデーションが失敗するとデータベースに何も登録されない" do
			group_params.merge!(name: "")
			expect{Group.create_a_new_group(group_params, user)}.not_to change{Group.count}
		end

		it "グループのバリデーションが失敗するとのerror属性に値が入る" do
			group_params.merge!(name: "")
			group = Group.create_a_new_group(group_params, user)
			expect(group.errors.any?).to be_truthy
		end

		it "トランザクション内で例外が発生するとデータベースには何も登録されない" do
			expect{Group.create_a_new_group(group_params, nil)}.to raise_error NoMethodError
			expect(Group.count).to eq(0)
			expect(GroupMember.count).to eq(0)
		end
	end

	describe '#admin?' do
		it 'userが管理者ならtrueを返す' do
			expect(user_group.admin?(user)).to be_truthy
		end

		it 'userがオペレーターならfalseを返す' do
			user.groups << other_user_group
			expect(other_user_group.admin?(user)).to be_falsey
		end

		it { expect(other_user_group.admin?(user)).to be_falsey }
	end

	describe '#member?' do
		it { expect(user_group.member?(user)).to be_truthy }

		it 'userがオペレーターならtrueを返す' do
			other_user.groups << user_group
			expect(user_group.member?(other_user)).to be_truthy
		end

		it { expect(other_user_group.member?(user)).to be_falsey }
	end
end


