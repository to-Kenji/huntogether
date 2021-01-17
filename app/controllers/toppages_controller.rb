class ToppagesController < ApplicationController
  def index
    @techniques = Technique.all.recent.page(params[:page]).per(5)
    if @q = Technique.ransack(params[:q])
      @techniques = @q.result.recent.page(params[:page]).per(5)
    end
    @technique_ranks = Technique.create_technique_ranks
  end
end
