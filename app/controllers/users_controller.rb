class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :followings, :followers]
  def show
    @techniques = @user.techniques.recent.paginate(params, 3)
    respond_to do |format|
      format.html
      format.js {render 'layouts/shared/paginate'}
    end
  end

  def favorites
    @techniques = current_user.favorites.paginate(params, 5)
    if @q = @techniques.ransack(params[:q])
      @techniques = @q.result.recent.paginate(params, 5)
    end
    respond_to do |format|
      format.html
      format.js {render 'layouts/shared/paginate'}
    end
    
    @technique_ranks = Technique.create_technique_ranks
  end

  def followings
    @followings = @user.followings.paginate(params, 10)
  end

  def followers
    @followers = @user.followers.paginate(params, 10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
