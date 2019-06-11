class AdminController < ApplicationController
  
   def index
     @comments =  Comment.all
     @complaints = Complaint.where(dumpster: false) 
     @dumpster = Complaint.where(dumpster: true)
   end

   def dumpster
     @complaints = search_dumpster(params[:search])
     if !@complaints.present?
        @complaints = []
     end
     
   end

   def users
     @users = search_user(params[:search])
     if !@users.present?
        @users = []
     end  
   end

   def blacklist
     @users = search_blacklist(params[:search])
     if !@users.present?
        @users = []
     end    
   end

   def search_blacklist(search)
     if search
        @users = User.where('(username LIKE ? or name LIKE ? or email LIKE ?) and blacklist = 1', "%#{search}%","%#{search}%", "%#{search}%")
     else
        @users = User.where(blacklist: true)
     end
   end

   def search_dumpster(search)
     if search
        @complaints = Complaint.where('(title LIKE ? or content LIKE ?) and dumpster = 1', "%#{search}%","%#{search}%")
     else
        @complaints = Complaint.where(dumpster: true)
     end
   end

   def search_user(search)
     if search
        @users = User.where('(username LIKE ? or name LIKE ? or email LIKE ?)', "%#{search}%","%#{search}%", "%#{search}%")
     else
        @users = User.all
     end
   end
end
