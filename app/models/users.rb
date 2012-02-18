class Users < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password 

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence:true
  validates :email,presence:true, format:{with:valid_email_regex}, uniqueness:{case_sensitive:false}
  validates :password, length:{minimum:6}

end
