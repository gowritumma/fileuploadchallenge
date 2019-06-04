class AddStatusToUploads < ActiveRecord::Migration[5.1]
 def self.up  
    add_column :uploads, :status, :integer
  end  

  def self.down  
    remove_column :uploads, :status
  end  
end
