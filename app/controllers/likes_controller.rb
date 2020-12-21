class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_technique

  def create
    Like.create(user_id: current_user.id, technique_id: params[:id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, technique_id: params[:id])
    like.destroy
  end

  private
  def set_technique
    @technique = Technique.find(params[:id])
  end

end
