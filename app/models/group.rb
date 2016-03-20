class Group < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	has_many :group_members, dependent: :destroy
	has_many :members, through: :group_members, source: :user

	def self.create_a_new_group(group, current_user)
		self.transaction do
			group.created_by = current_user.id
	    current_user.group_members.create!(group: group, role: :admin)
	    group.save!
	  end
	  true
	end

	def admin?(current_user)
		if group_members.find_by(user_id: current_user.id)
			group_members.find_by(user_id: current_user.id).admin?
		else
			false
		end
	end

	def member?(current_user)
		if group_members.find_by(user_id: current_user)
			group_members.find_by(user_id: current_user.id).admin?
		else
			false
		end
	end

end
