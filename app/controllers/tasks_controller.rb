class TasksController < ApplicationController
	before_action :set_task, only: [:update, :destroy]

	def index
		@task = Task.new
		@tasks_should_work_on = current_user.tasks.should_work_on.order(urgency: :DESC, importance: :DESC).page(params[:page])
		@tasks_rescently_done           = current_user.tasks.rescently_done
	end

	def create
		@task = Task.new(task_params)
		@task.user = current_user
		if @task.save
			redirect_to tasks_url, notice: "新しいタスクを作成しました"
		else
			render :index
		end
	end

	def update
		@task = current_user.tasks.find(params[:id])
		@task.status = :done
		if @task.save
			redirect_to tasks_url, notice: "タスクを完了しました"
		else
			redirect_to tasks_url, notice: "タスクの完了登録に失敗しました"
		end
	end

	def destroy
		@task.destroy
		redirect_to tasks_url, notice: "タスクを削除しました"
	end

	def done_registration
		params["tasks"].each do |checkbox|
			if checkbox.size==2
				done_task=Task.find(checkbox[":id"])
				done_task.status = :done
				done_task.save
			end
		end
		redirect_to tasks_url, notice: "タスクを完了しました"
	end


	private
		def task_params
			params.require(:task).permit(:name, :urgency, :importance, :status)
		end

		def set_task
			@task = current_user.tasks.find(params[:id])
		end


end
