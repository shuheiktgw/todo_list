class GroupMember < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	enum role: {operator: 0, admin: 1}

	validates :user_id, :uniqueness => {:scope => :group_id}
end
