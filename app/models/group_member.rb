class GroupMember < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	enum role: {operator: 0, admin: 1}
end
