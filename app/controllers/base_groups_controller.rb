class BaseGroupsController < ApplicationController

  private

    def current_group
      Group.find(params[:id])
    end

    def admin_required
      raise '403 Forbidden' unless current_group.admin?(current_user)
    end

    def member_only
      raise '403 Forbidden' unless current_group.member?(current_user)
    end
end
