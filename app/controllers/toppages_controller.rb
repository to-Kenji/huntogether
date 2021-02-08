class ToppagesController < ApplicationController
  def index
    @techniques = Technique.all.recent.paginate(params, 5)
    if @q = Technique.ransack(params[:q])
      @techniques = @q.result.recent.paginate(params, 5)
    end
    respond_to do |format|
      format.html
      format.js {render 'layouts/shared/paginate'}
    end
    @technique_ranks = Technique.create_technique_ranks
  end
end
