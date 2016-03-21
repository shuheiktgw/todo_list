class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_group

  def after_sign_in_path_for(resource)
    tasks_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

    def current_group
      if params[:controller] == 'groups'
        group ||= Group.find(params[:id])
      elsif params[:controller] == 'group_members' || params[:controller] == 'group_admins'
        group ||= Group.find(params[:group_id])
      end
    end

    def admin_required
      raise '403 Forbidden' unless current_group.admin?(current_user)
    end

    def member_only
      raise '403 Forbidden' unless current_group.member?(current_user)
    end
end
