class TimelineController < ApplicationController
  before_action :authenticate_user!

  def index
    @following_techniques = current_user.following_techniques.recent.page(params[:page]).per(5)
    if @q = @following_techniques.ransack(params[:q])
      @following_techniques = @q.result.recent.page(params[:page]).per(5)
    end

    respond_to do |format|
      format.html
      format.js {render :paginate}
    end
    
    @technique_ranks = Technique.create_technique_ranks
  end
end

