class Contact < ActiveRecord::Base
  has_attached_file :profile_pic, :default_url => "/images/missing.png"
end
