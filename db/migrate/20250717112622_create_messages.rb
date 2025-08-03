class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :listing_id

      t.timestamps
    end
  end
end
