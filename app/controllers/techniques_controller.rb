class TechniquesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_technique, only: %i[show edit update destroy]

  def show
    @user = @technique.user
    @comment = Comment.new
    @comments = @technique.comments.recent
  end

  def new
    @technique = Technique.new
  end

  def create
    @technique = current_user.techniques.build(technique_params)
    tag_list = params[:technique][:tag_name].split(nil)
    if @technique.save
      @technique.save_tags(tag_list)
      flash[:notice] = '投稿しました。'
      redirect_to @technique
    else
      flash.now[:error] = '投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @tag_list = @technique.tags.pluck(:tag_name).join(' ')
  end

  def update
    tag_list = params[:technique][:tag_name].split(nil)
    if @technique.update(technique_params)
      @technique.save_tags(tag_list)
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
    redirect_to root_path
  end

  def tagged_index
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @techniques = @tag.techniques.recent.page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js { render 'layouts/shared/paginate' }
    end
  end

  private

  def technique_params
    params.require(:technique).permit(:title, :body, :youtube_url, :weapon_id, :monster_id)
  end

  def set_technique
    @technique = Technique.find(params[:id])
  end
end
