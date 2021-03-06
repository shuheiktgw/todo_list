class GroupMembersController < BaseGroupsController
  before_action :admin_required, except: :index
  before_action :member_only, only: :index

  def index
    @members = current_group.members
  end

  def new
  end

  def create
    emails = Array(params[:members][:email].strip.split(','))
    if registered_emails = User.register_from_emails(emails, current_group)
      if registered_emails.nil?
        redirect_to :back, notice: "メンバーが登録に失敗しました"
      else
        redirect_to current_group, notice: "#{registered_emails.join(", ")}をメンバー登録しました"
      end
    else
      redirect_to :back, notice: "有効なemailアドレスを入力してください"
    end
  end

  def destroy
    current_group.group_members.find_by(user_id: params[:id]).delete
    redirect_to :back, notice: "メンバーの登録を解除しました"
  end

  private
    def current_group
      Group.find(params[:group_id])
    end



end
