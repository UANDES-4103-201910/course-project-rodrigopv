class ComplaintsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :like, :dislike, :follow, :unfollow]
  before_action :set_complaint, only: [:show, :edit, :update, :destroy, :like, :dislike, :follow, :unfollow, :republish, :unpublish, :addmedia, :uploadmedia]
  before_action :restrict, only: [:show]
  skip_before_action :verify_authenticity_token, :only => [:create, :update, :destroy]
  

  # GET /complaints
  # GET /complaints.json
  def index
    @complaints = Complaint.all
  end

  # GET /complaints/1
  # GET /complaints/1.json
  def show
    @comment = Comment.new
  end

  # GET /complaints/new
  def new
    @complaint = Complaint.new
  end

  # GET /complaints/1/edit
  def edit
  end

  # POST /complaints
  # POST /complaints.json
  def create
    # ({user_id: 1, category_id: 1, entity_id: 1, title: "I need more time", content: "please?"}

    newparams = complaint_params
    newparams[:user_id] = current_user.id
    @complaint = Complaint.new(newparams)

    respond_to do |format|
      if @complaint.save
        format.html { redirect_to @complaint, notice: 'Complaint was successfully created.' }
        format.json { render :show, status: :created, location: @complaint }
      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complaints/1
  # PATCH/PUT /complaints/1.json
  def update
    respond_to do |format|
      if @complaint.update(complaint_params)
        format.html { redirect_to @complaint, notice: 'Complaint was successfully updated.' }
        format.json { render :show, status: :ok, location: @complaint }
      else
        format.html { render :edit }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complaints/1
  # DELETE /complaints/1.json
  def destroy
    @complaint.destroy
    respond_to do |format|
      format.html { redirect_to complaints_url, notice: 'Complaint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    current_user.like!(@complaint)
    flash[:notice] = "You liked this complaint."
    redirect_to complaint_path(@complaint) 
  end

  def dislike
    current_user.unlike!(@complaint) 
    flash[:notice] = "You no longer like this complaint."
    redirect_to complaint_path(@complaint) 
  end

  def follow
    current_user.follow!(@complaint)
    flash[:notice] = "You followed this complaint."
    redirect_to complaint_path(@complaint) 
  end

  def unfollow
    current_user.unfollow!(@complaint) 
    flash[:notice] = "You unfollowed this complaint."
    redirect_to complaint_path(@complaint) 
  end

  def republish
    flash[:notice] = "The complaint has been republished"
    @complaint.dumpster = false
    @complaint.save     
    redirect_to complaint_path(@complaint) 
  end

  def unpublish
    flash[:notice] = "The complaint has been added to the dumpster"
    @complaint.dumpster = true
    @complaint.save
    redirect_to complaint_path(@complaint)
  end

  def uploadmedia
  end

  def addmedia
    @complaint.media.attach(upload_params[:image])
    flash[:notice] = "Image has been uploaded"
    redirect_to @complaint
  end



  private
    def restrict
      if @complaint.dumpster and !user_signed_in?
        flash[:notice] = "Sorry, this post is currently at dumpster (not signed in)"
        redirect_to('/')
        return
      end
      is_admin = false
      if user_signed_in?
         is_admin = !current_user.has_role?(:superadmin) || !current_user.has_role?(:admin)
      end
      if @complaint.dumpster and !is_admin
        flash[:notice] = "Sorry, this post is currently at dumpster (not superadmin)"
        redirect_to('/')
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params[:complaint][:entity_id] = 1
      params[:complaint][:category_id] = 1

      params.require(:complaint).permit(:category_id, :entity_id, :title, :content, :main_image, :lat, :lng)
    end

    def upload_params
      params.permit(:image, :id)
    end 
end
