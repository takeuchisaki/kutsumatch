class CreateShoeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :shoe_comments do |t|
      
      t.integer :shoe_id,     null: false
      t.integer :customer_id, null: false
      t.text    :comment,     null: false

      t.timestamps
    end
  end
end
