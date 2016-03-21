class Group < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	has_many :group_members, dependent: :destroy
	has_many :members, through: :group_members, source: :user

	def self.create_a_new_group(params, user)
		group = new(params)
		self.transaction do
			group.created_by = user.id
	    user.group_members.create!(group: group, role: :admin)
	    group.save!
	  end
	  group
	end

	def admin?(user)
		member = group_members.find_by(user_id: user)
		return false if member.nil?
		member.admin?
	end

	def member?(user)
		member = group_members.find_by(user_id: user)
		return false if member.nil?
		member
	end

end
