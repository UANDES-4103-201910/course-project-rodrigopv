class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :restore, :blacklist, :changepassword]
  before_action :authenticate_user!, only: [:new, :create, :update, :delete, :destroy, :changepassword]

  skip_before_action :verify_authenticity_token, :only => [:create, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = search(params[:search])
    if !@users.present?
      @users = []
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if params[:avatar].present?
         res = @user.avatar.attach(params[:avatar])
      end
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def restore
    flash[:notice] = "The user has been restored"
    @user.blacklist = false
    @user.save
    redirect_to admin_blacklist_path
  end

  def blacklist
    flash[:notice] = "The user has been blacklisted"
    @user.blacklist = true
    @user.save
    redirect_to admin_blacklist_path
  end

  def changepassword 
    puts "Changing password to"
    puts changepassword_params[:password]
    puts @user.id
    @user.password = params[:password]
    @user.password_confirmation = params[:password]
    @user.save
    flash[:notice] = "User password has been changed."
    redirect_to admin_users_path
  end


  def search(search)
     if search
        @users = User.where('username LIKE ? or name LIKE ? or email LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
     else
        @users = User.all
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:pk].present?
        @user = User.find(params[:pk])
        if params[:value].present?
           params[:user] = { bio: params[:value] }
        end
        if params[:avatar].present? and !params[:user].present?
           params[:user] = { avatar: params[:avatar] }
        end
      else
        if params[:id].present?
          @user = User.find(params[:id])
        else
          @user = User.find(params[:user_id])
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :username, :password, :email, :role, :bio, :search)
    end

    def changepassword_params
      params.permit(:password, :utf8, :authenticity_token, :user_id)
    end
    
end
