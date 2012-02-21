class MicropostsController < ApplicationController
  before_filter :signed_in_user

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success]="Micropost created!"
      redirect_to root_path
    else
      @feed=current_user.feed
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by_id(params[:id])
    @micropost.destroy
    redirect_back_or root_path
  end

end
