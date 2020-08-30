class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
