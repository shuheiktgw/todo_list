class Group < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	has_many :group_members, dependent: :destroy
	has_many :members, through: :group_members, source: :user
end
