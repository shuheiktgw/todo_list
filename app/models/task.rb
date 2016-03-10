class Task < ActiveRecord::Base
	belongs_to :user

	validates :name, presence: true
	validates :description, length: {maximum: 150}



	enum urgency: {urgency_low: 0, urgency_middle: 1, urgency_high: 2}
	enum importance: {importance_low: 0, importance_middle: 1, importance_high: 2}
	enum status: {not_yet: 0, wip: 1, done: 2}

	task_table = Task.arel_table
	scope :should_work_on, ->{where(task_table[:status].not_eq(2))}
	scope :rescently_done, ->{where(task_table[:status].eq(2), task_table[:updated_at].gt(3.days.ago))}
end
