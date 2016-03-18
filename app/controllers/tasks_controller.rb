class TasksController < ApplicationController
	before_action :set_task, only: [:update, :destroy]

	def index
		@task = Task.new
		@tasks_should_work_on = current_user.tasks.should_work_on.where(group_id: nil).order(urgency: :DESC, importance: :DESC).page(params[:page])
		@tasks_rescently_done = current_user.tasks.rescently_done.where(group_id: nil)
	end

	def create
		@task = Task.new(task_params)
		@task.user = current_user
		if @task.save
				redirect_to :back, notice: "新しいタスクを作成しました"
		else
				redirect_to :back, notice: "新しいタスクの作成に失敗しました"
		end
	end

	def update
		@task.done!
		redirect_to tasks_url, notice: "タスクを完了しました"
	end


	def destroy
		@task.destroy
		redirect_to :back, notice: "タスクを削除しました"
	end

	def done_registration
		if params["checked_id"].nil?
			redirect_to :back, notice: "完了登録するタスクを選択してください"
		else
			Task.done_multiple(current_user, params["checked_id"])
			redirect_to :back, notice: "タスクを完了登録しました"
		end
	end


	private
		def task_params
			params.require(:task).permit(:name, :urgency, :importance, :status, :description, :group_id)
		end

		def set_task
			@task = current_user.tasks.find(params[:id])
		end


end
