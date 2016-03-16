class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.members << current_user
      redirect_to @group, notice: "新しいグループを作成しました"
    else
      redirect_to :back, notice: "グループの作成に失敗しました"
    end
  end

  def show
    @task = Task.new
    @tasks_should_work_on = current_group.tasks.should_work_on.order(urgency: :DESC, importance: :DESC).page(params[:page])
    @tasks_rescently_done = current_group.tasks.rescently_done
  end

  def edit
  end

  def update
    if @group.update_attributes(group_params)
      redirect_to @group, notice: "グループの情報を更新しました"
    else
      redirect_to @group, notice: "グループ情報の更新に失敗しました"
    end
  end

  def destroy
    @group.destroy
    redirect_to current_user, notice: "グループ情報の更新に失敗しました"
  end

  def members
    @members = current_group.members
  end

  def member_search

  end

  def member_register
    current_group.members << @member
  end

  def member_deregister
    current_group.members.destroy(User.find(params[:member_id]))
    redirect_to :back, notice: "メンバーの登録を解除しました"
  end

  private
    def group_params
      params.require(:group).permit(:name, :description, :created_by)
    end

    def set_group
      @group = Group.find(params[:id])
    end

    def current_group
      current_group = Group.find(params[:id])
    end
end
