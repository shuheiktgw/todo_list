class Group < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	has_many :group_members, dependent: :destroy
	has_many :members, through: :group_members, source: :user

	def admin?(current_user)
		group_members.find_by(user_id: current_user.id).admin?
	end

	def member?(current_user)
		group_members.find_by(user_id: current_user)
	end

end
