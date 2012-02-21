class UserController < ApplicationController
  before_filter :signed_in_user, only: [:index,:edit,:update]
  before_filter :correct_user,only:[:edit,:update]
  before_filter :admin_user,only: :destroy
  before_filter :only_unsigned, only:[:new,:create]

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

  def index
    @user = Users.paginate(page:params[:page])
  end

  def edit
  end
  def update
    if @user.update_attributes(params[:users])
      flash[:success]= "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    Users.find(params[:id]).destroy
    flash[:success]="User destroyed"
    redirect_to "/user"
  end
  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice:"Please sign in"
      end
    end
    def correct_user
      @user = Users.find(params[:id])
      redirect_to root_path, notice:"Incorect user" unless current_user?(@user)
    end
    def admin_user
      redirect_to root_path, notice:"only admin can do that" unless current_user.admin?
    end
    def only_unsigned
      redirect_to root_path, notice:"only unsigned user can crate new" if signed_in? 
    end
end
