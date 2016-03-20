class Task < ActiveRecord::Base
	belongs_to :user

	validates :name, presence: true
	validates :description, length: {maximum: 150}



	enum urgency: {urgency_low: 0, urgency_middle: 1, urgency_high: 2}
	enum importance: {importance_low: 0, importance_middle: 1, importance_high: 2}
	enum status: {not_yet: 0, wip: 1, done: 2}

	scope :should_work_on, ->{ where.not(status: statuses[:done]) }
	scope :rescently_done, ->{ done.where(arel_table[:updated_at].gt(3.days.ago)) }

	def self.done_multiple(user, ids)
		self.transaction do
			ids.each do |id|
				user.tasks.find(id).done!
			end
		end
	end

end
