class Task < ActiveRecord::Base
	belongs_to :user

	validates :name, presence: true

	scope :should_work_on, ->{where("status <> ?", "2")}
	scope :rescently_done, -> {where(["status = ? and updated_at > ?", 2, 3.days.ago])}
end
