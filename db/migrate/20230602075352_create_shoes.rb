class CreateShoes < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes do |t|
      
      t.integer :customer_id, null: false
      t.string  :name,        null: false
      t.text    :body,        null: false
      t.string  :maker
      t.integer :genre_id,    null: false
      t.string  :sports_name
      t.string  :shoes_size,  null: false
      t.integer :price
      t.string  :match_rate,  null: false
      
      t.timestamps
    end
  end
end
