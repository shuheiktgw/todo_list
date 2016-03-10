class Task < ActiveRecord::Base
	belongs_to :user

	validates :name, presence: true

	scope :should_work_on, ->{where("status <> ?", ":done")}
	scope :rescently_done, -> {where(["status = ? and updated_at > ?", 2, 3.days.ago])}

	enum urgency: {urgency_low: 0, urgency_middle: 1, urgency_high: 2}
	enum importance: {importance_low: 0, importance_middle: 1, importance_high: 2}
	enum status: {not_yet: 0, wip: 1, done: 2}
end
