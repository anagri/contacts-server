class Contact < ActiveRecord::Base
  has_attached_file :profile_pic, :default_url => "/images/missing.png"
  validates_attachment_content_type :profile_pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :first_name, presence: true
  validates :first_name, length: {minimum: 2}, if: Proc.new {|c| c.first_name.present? }

  validates :last_name, presence: true
  validates :last_name, length: {minimum: 2}, if: Proc.new {|c| c.last_name.present? }

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, if: Proc.new {|c| c.email.present? }

  validates_format_of :phone_number, :with => /\+?\d{10,12}/i, if: Proc.new {|c| c.phone_number.present? }
end
