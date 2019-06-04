class CreateUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :uploads do |t|
      t.string :filename
      t.string :url
      t.integer :user_id
      t.boolean :processed
      t.timestamps
    end
  end
end
