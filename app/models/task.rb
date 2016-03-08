class Task < ActiveRecord::Base
	belongs_to :user

	scope :should_work_on, ->{where("status <> ?", "3")}
	scope :done, -> {where("status: ? AND ? < updated_at", 3, 5.days.ago)}

end
