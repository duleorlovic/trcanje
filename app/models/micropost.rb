class Micropost < ActiveRecord::Base
  validates :users_id, presence:true
  attr_accessible :content
  belongs_to :users
  default_scope order:'microposts.created_at DESC'
  validates :content, presence: true, length: { maximum:140} 
end
