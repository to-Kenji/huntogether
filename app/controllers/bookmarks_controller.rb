class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @technique = Technique.find(params[:technique_id])
    current_user.favorite(@technique)
    respond_to do |format|
      format.html {redirect_to @technique}
      format.js
    end
  
  end

  def destroy
    @technique = Technique.find(params[:technique_id])
    current_user.unfavorite(@technique)
    respond_to do |format|
      format.html {redirect_to @technique}
      format.js
    end
  end
end
