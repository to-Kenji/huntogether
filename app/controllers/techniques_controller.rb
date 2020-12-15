class TechniquesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @technique = Technique.find(params[:id])
    @like = Like.new
  end

  def new
    @technique = Technique.new
  end

  def create
    @technique = current_user.techniques.build(technique_params)
    url = params[:technique][:youtube_url].last(11)
    @technique.youtube_url = url
    if @technique.save
      flash[:notice] = '投稿しました！'
      redirect_to technique_path(@technique)
    else
      flash.now[:error] = '投稿に失敗しました！'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def technique_params
    params.require(:technique).permit(:title, :body, :youtube_url, :weapon_id, :monster_id)
  end
end
