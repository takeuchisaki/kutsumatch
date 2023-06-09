class CreateShoes < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes do |t|

      t.integer :customer_id, null: false
      t.string  :name,        null: false
      t.text    :body,        null: false
      t.string  :shoe_size,   null: false
      t.integer :price
      t.integer :match_rate
      t.string  :tag_name

      t.timestamps
    end
  end
end
