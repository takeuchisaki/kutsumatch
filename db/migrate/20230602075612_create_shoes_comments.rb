class CreateShoesComments < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes_comments do |t|
      
      t.integer :shoes_id,    null: false
      t.integer :customer_id, null: false
      t.text    :comment,     null: false
      
      t.timestamps
    end
  end
end
