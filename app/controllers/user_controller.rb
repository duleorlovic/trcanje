class UserController < ApplicationController
  before_filter :signed_in_user, only: [:edit,:update]
  def new
     @user = Users.new(params[:users])
  end
  
  def create
    @user = Users.new(params[:users])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = Users.find(params[:id])
  end

  #def index
  #end

  def edit
    @user = Users.find(params[:id])
  end
  def update
    @user = Users.find(params[:id])
    if @user.update_attributes(params[:users])
      flash[:success]= "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  private
    def signed_in_user
      redirect_to signin_path, notice:"Please sign in" unless signed_in?
    end
end
