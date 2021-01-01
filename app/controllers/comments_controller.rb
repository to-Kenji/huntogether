class CommentsController < ApplicationController
  def create
    @technique = Technique.find(params[:technique_id])
    @comments = @technique.comments.order(created_at: :desc)
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(technique_id: params[:technique_id])
  end
end