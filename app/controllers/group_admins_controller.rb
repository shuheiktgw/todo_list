class GroupAdminsController < BaseGroupsController

  before_action :admin_required

  def update
    if params[:act] == "registration"
      current_group.group_members.find_by(user_id: params[:id]).admin!
      redirect_to :back, notice: "メンバーを管理者登録しました"
    else
      current_group.group_members.find_by(user_id: params[:id]).operator!
      redirect_to :back, notice: "メンバーの管理者権限を削除しました"
    end
  end


  private

  def current_group
    Group.find(params[:group_id])
  end

end
