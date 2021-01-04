class TechniquesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_technique, only: [:show, :edit, :update, :destroy]
  before_action :set_difficulties, only: [:index, :new, :show, :edit, :create]
  def index
    @techniques = Technique.all.page(params[:page]).per(8)
    if @q = Technique.ransack(params[:q])
      @techniques = @q.result.page(params[:page]).per(8)
    end
  end

  def show
    @user = @technique.user
    @comment = Comment.new
    @comments = @technique.comments.order(created_at: :desc)
  end

  def new
    @technique = Technique.new
  end

  def create
    @technique = current_user.techniques.build(technique_params)
    url = params[:technique][:youtube_url].last(11)
    @technique.youtube_url = url
    if @technique.save
      flash[:notice] = '投稿しました。'
      redirect_to @technique
    else
      flash.now[:error] = '投稿に失敗しました。'
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
    params.require(:technique).permit(:title, :body, :youtube_url, :difficulty, :weapon_id, :monster_id)
  end

  def set_technique
    @technique = Technique.find(params[:id])
  end

  def set_difficulties
    @difficulties = [ '低', '中', '高' ]
  end
end
