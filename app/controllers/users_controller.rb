class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @techniques = @user.techniques.recent.page(params[:page]).per(5)
  end
end
