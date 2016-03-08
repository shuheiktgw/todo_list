class TasksController < ApplicationController
	def index
		@user = current_user
		@tasks = @user.tasks
		@tasks_should_work_on = @user.tasks.should_work_on.order(urgency: :DESC)
		@taske_done           = @user.tasks.done
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(task_params)
		@task.user = current_user
		if @task.save
			redirect_to static_pages_show_url, notice: "新しいタスクを作成しました"
		else
			render "new"
		end
	end

	def edit
		@task = current_user.tasks.find(params[:id])
	end

	def update
		@task = current_user.tasks.find[params[:id]]
		@task.assign_attributes(task_params)
		if @task.save
			redirect_to static_pages_show_url, notice: "タスクを更新しました"
		else
			render "edit"
		end
	end

	def destroy
	end

	private
		def task_params
			params.require(:task).permit(:name, :urgency, :importance, :status)
		end


end
