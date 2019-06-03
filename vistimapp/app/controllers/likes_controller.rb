class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_complaint
  before_action :find_like, only: [:destroy]
  
  def create
     if already_liked?
       flash[:notice] = "You already like this complaint"
     else
       @complaint.likes.create(user_id: current_user.id)
     end
     redirect_to complaint_path(@complaint)
  end

  def destroy
     if !(already_liked?)
        flash[:notice] = "Can't unlike..."
     else
        @like.destroy
     end
     redirect_to complaint_path(@complaint)
  end


  private
  def find_complaint
     @complaint = Complaint.find(params[:complaint_id])
  end

  def already_liked?
     Like.where(user_id: current_user.id, complaint_id: params[:complaint_id]).exists?
  end      
  
  def find_like
     @like = @complaint.likes.find(params[:id])
  end

end
