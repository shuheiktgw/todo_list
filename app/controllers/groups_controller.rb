class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group, notice: "新しいグループを作成しました"
    else
      redirect_to @group, notice: "グループの作成に失敗しました"
    end
  end

  def show
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

  private
    def group_params
      params.require(:group).permit(:name, :description, :created_by)
    end

    def set_group
      @group = Group.find(params[:id])
    end
end
