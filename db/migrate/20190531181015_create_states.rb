class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string :name
      t.string :abbr
      t.timestamps
    end
    add_index :states, :name
    add_index :states, :abbr, unique: true
  end
end
