class TimelineController < ApplicationController
  before_action :authenticate_user!

  def index
    @techniques = current_user.following_techniques.recent.page(params[:page]).per(5)
    if @q = @techniques.ransack(params[:q])
      @techniques = @q.result.recent.page(params[:page]).per(5)
    end
    respond_to do |format|
      format.html
      format.js { render 'layouts/shared/paginate' }
    end
    @technique_ranks = Technique.create_technique_ranks
  end
end
