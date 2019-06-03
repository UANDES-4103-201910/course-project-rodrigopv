class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @complaint = Complaint.find(params[:complaint_id])
    
    @comment = @complaint.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
       redirect_to @complaint, notice: "Comment added."
    else
       redirect_to @complaint, notice: "Couldn't add comment to complaint."
    end
  end

  def destroy
    @comment = Comment.find_by(params[:id])
    @comment.delete
    redirect_to '/admin', notice: "Comment deleted..."
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
 
end
