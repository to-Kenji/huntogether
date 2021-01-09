class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    technique = Technique.find(params[:technique_id])
    current_user.favorite(technique)
    flash[:notice] = 'お気に入り登録'
    redirect_to technique
  end

  def destroy
    technique = Technique.find(params[:technique_id])
    current_user.unfavorite(technique)
    flash[:notice] = 'お気に解除'
    redirect_to technique
  end
end
