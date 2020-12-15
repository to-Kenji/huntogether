class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    technique = Technique.find(params[:technique_id])
    current_user.do_like(technique)
    flash[:notice] = 'いいねした'
    redirect_to technique
  end

  def destroy
    technique = Technique.find(params[:technique_id])
    current_user.do_unlike(technique)
    flash[:notice] = 'いいね解除'
    redirect_to technique
  end

end
