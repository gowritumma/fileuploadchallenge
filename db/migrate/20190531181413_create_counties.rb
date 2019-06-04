class CreateCounties < ActiveRecord::Migration[5.1]
  def change
    create_table :counties do |t|
      t.string :name
      t.string :city
      t.string :zip
      t.references :state
      t.timestamps
    end
  end
end
