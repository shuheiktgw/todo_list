class Task < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	validates :name, presence: true
	validates :description, length: {maximum: 150}



	enum urgency: {urgency_low: 0, urgency_middle: 1, urgency_high: 2}
	enum importance: {importance_low: 0, importance_middle: 1, importance_high: 2}
	enum status: {not_yet: 0, wip: 1, done: 2}

	scope :should_work_on,   ->{ where.not(status: statuses[:done]) }
	scope :rescently_done,   ->{ done.where(arel_table[:updated_at].gt(3.days.ago)) }
	scope :individual_tasks, ->{ where(group_id: nil) }


	def self.done_multiple(user, ids)
		self.transaction do
			ids.each do |id|
<<<<<<< HEAD
				done_task = user.tasks.find(id)
				done_task.status = :done
				done_task.done_date = Date.today

				done_task.save!
=======
				user.tasks.find(id).done!
>>>>>>> parent of 877083b... add task tracking features
			end
		end
	end

end
