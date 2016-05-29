class PaperClip < ActiveRecord::Migration
  def up
    add_attachment :contacts, :profile_pic
  end

  def down
    remove_attachment :users, :profile_pic
  end
end
