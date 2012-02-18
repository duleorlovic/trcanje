class UserController < ApplicationController
  def new
     @user = Users.new(params[:users])
  end
  
  def create
    @user = Users.new(params[:users])
    if @user.save
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
  end

  def edit
  end
end
