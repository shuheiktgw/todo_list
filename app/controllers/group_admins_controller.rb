class GroupAdminsController < ApplicationController

  before_action :admin_required

  def create
    current_group.group_members.find_by(user_id: params[:id]).admin!
    redirect_to :back, notice: "メンバーを管理者登録しました"
  end

  def destroy
    current_group.group_members.find_by(user_id: params[:id]).operator!
    redirect_to :back, notice: "メンバーの管理者権限を削除しました"
  end

end
