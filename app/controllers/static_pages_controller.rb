class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if signed_in?
    @feed = current_user.feed if signed_in?
  end

  def help
  end

  def contact
  end

end
