module UsersHelper

  # return Gravat for user
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
#    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
    gravatar_url = "rails.png"
    image_tag(gravatar_url, alt:user.name,class:"gravatar")
  end

end
