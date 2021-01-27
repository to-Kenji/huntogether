class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @techniques = @user.techniques.recent.page(params[:page]).per(3)
    respond_to do |format|
      format.html
      format.js {render :techniques_paginate}
    end
  end

  def favorites
    @favorites = current_user.favorites.page(params[:page]).per(5)
    if @q = @favorites.ransack(params[:q])
      @favorites = @q.result.recent.page(params[:page]).per(5)
    end

    respond_to do |format|
      format.html
      format.js {render :favorites_paginate}
    end
  end
end
