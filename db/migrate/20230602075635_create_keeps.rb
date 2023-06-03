class CreateKeeps < ActiveRecord::Migration[6.1]
  def change
    create_table :keeps do |t|
      
      t.integer :shoes_id,    null: false
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end
