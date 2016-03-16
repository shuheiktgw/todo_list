class Group < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
end
