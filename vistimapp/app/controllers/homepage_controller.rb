class HomepageController < ApplicationController
  def index
    @users = User.all
    @complaints = Complaint.all

  end
end
