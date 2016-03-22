class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    redirect_to :tasks if user_signed_in?
  end

  def show
  end
end
