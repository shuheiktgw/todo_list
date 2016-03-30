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

	scope :total_then, ->(date){ where("created_at <= ?", date+1) } #dateはその日の00:00:00に同じ
	scope :not_yet_then, ->(date){ where("created_at <= ? and (done_date > ? or done_date IS NULL)", date+1, date+1) }
	scope :done_until_then, ->(date){ where("created_at <= ? and done_date <= ?", date+1, date+1) }
	scope :added_then, ->(date){ where("? <= created_at and created_at <= ?", date, date+1) }



	def self.done_multiple(user, ids)
		self.transaction do
			ids.each do |id|
				done_task = user.tasks.find(id)
				done_task.done!
				done_task.done_date = Timewithzon.today

				done_task.save!
			end
		end
	end

end
