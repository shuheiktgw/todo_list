class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :admin_required, only: [:edit, :update, :destroy, :member_search, :member_register, :member_deregister, :member_admin, :member_deadmin]
  before_action :member_only, except: [:new, :create]
  helper_method :group_admin?


  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.groups << @group
      current_user.group_members.find_by(group_id: @group).admin! #要リファクタリング
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
    redirect_to current_user, notice: "グループを削除しました"
  end

  def members
    @members = current_group.members
  end

  def member_search
  end

  def member_register
    emails = Array(params[:members][:email].strip.split(','))
    if registered_emails = User.register_from_emails(emails)
      redirect_to @group, notice: "#{registered_emails}をメンバー登録しました"
    else
      redirect_to :back, notice: "有効なemailアドレスを入力してください"
    end
  end

  def member_deregister
    current_group.members.destroy(User.find(params[:member_id]))
    redirect_to :back, notice: "メンバーの登録を解除しました"
  end

  def member_admin
    current_group.group_members.find_by(user_id: params[:member_id]).admin!
    redirect_to :back, notice: "メンバーを管理者登録しました"
  end

  def member_deadmin
    current_group.group_members.find_by(user_id: params[:member_id]).operator!
    redirect_to :back, notice: "メンバーの管理者権限を削除しました"
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

    def group_admin?
      current_user.group_members.find_by(group_id: current_group).admin?
    end

    def admin_required
      raise '403 Forbidden' unless group_admin?
    end

    def member_only
      raise '403 Forbidden' unless current_group.group_members.find_by(user_id: current_user)
    end

end
