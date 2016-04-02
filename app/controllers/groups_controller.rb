class GroupsController < BaseGroupsController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :admin_required, only: [:edit, :update, :destroy]
  before_action :member_only, except: [:new, :create]


  def new
    @group = Group.new
  end

  def create
    if (@group = Group.create_a_new_group(group_params, current_user))
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
    redirect_to :new_group, notice: "グループを削除しました"
  end

  private
    def group_params
      params.require(:group).permit(:name, :description)
    end

    def set_group
      @group ||= Group.find(params[:id])
    end

end
