class ToppagesController < ApplicationController
  def index
    @techniques = Technique.all.recent.page(params[:page]).per(5)
    if @q = Technique.ransack(params[:q])
      @techniques = @q.result.recent.page(params[:page]).per(5)
    end
    respond_to do |format|
      format.html
      format.js
    end
    @technique_ranks = Technique.create_technique_ranks
  end
end
