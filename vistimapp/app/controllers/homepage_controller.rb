class HomepageController < ApplicationController
  def index
    @users = User.all
    @complaints = Complaint.all
    render layout: "homepage"
  end
 
  def login
  end
end
