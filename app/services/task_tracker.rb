class TaskTracker
  def initialize(task_owner)
    @tasks = task_owner.tasks
  end

#Dateごとの形に成形したリレーショナルオブジェクト作る→Hashに格納

  def task_tracking
    duration = ((Date.today-30)..Date.today)
    tasks_hash = {}
    duration.each do |date|
      tasks_hash[date] = [number_of_not_yet_tasks(date), number_of_done_tasks(date), ratio_of_not_yet_tasks(date), number_of_added_tasks(date)]
    end
    tasks_hash
  end

  def get_the_number_of_done_tasks_by_date
    @tasks.group_by_day(:done_date, "count")
  end

  def get_the_number_of_added_tasks_by_date
    @tasks.group_by_day(:created_at, "count")
  end

  def get_the_number_of_not_yet_tasks
    @tasks.select
  end





  def number_of_done_tasks(date)
    @tasks.done_until_then(date).count
  end

  def number_of_tasks(date)
    @tasks.total_then(date).count
  end

  def ratio_of_not_yet_tasks(date)
    return 0 if number_of_tasks(date) == 0
    number_of_not_yet_tasks(date).to_f/number_of_tasks(date).to_f * 100
  end

  def number_of_added_tasks(date)
    @tasks.added_then(date).count
  end
end
