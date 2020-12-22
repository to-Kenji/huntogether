class TechniquesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_technique, only: [:show, :edit, :update, :destroy]
  def index
    @techniques = Technique.all.order(id: "DESC").page(params[:page]).per(4)
  end

  def show
    @like = Like.new
    @user = @technique.user
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
      redirect_to @technique
    else
      flash.now[:error] = '投稿に失敗しました！'
      render :new
    end
  end

  def edit
  end

  def update
    if @technique.update(technique_params)
      flash[:notice] = '更新しました。'
      redirect_to @technique
    else
      flash.now[:error] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @technique.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to techniques_path
  end

  private

  def technique_params
    params.require(:technique).permit(:title, :body, :youtube_url, :weapon_id, :monster_id)
  end

  def set_technique
    @technique = Technique.find(params[:id])
  end
end
