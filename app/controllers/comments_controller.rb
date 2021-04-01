class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @technique = Technique.find(params[:technique_id])
    @comments = @technique.comments.recent
    @comment = current_user.comments.build(comment_params)
    @comment.save
    render :index
  end

  def destroy
    @technique = Technique.find(params[:technique_id])
    @comments = @technique.comments.recent
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(technique_id: params[:technique_id])
  end
end
