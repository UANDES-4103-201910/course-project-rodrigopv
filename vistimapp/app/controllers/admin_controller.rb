class AdminController < ApplicationController
  
   def index

    @comments =  Comment.all

    @complaints = Complaint.all 
   end

end
