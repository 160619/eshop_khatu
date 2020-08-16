class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :quantity
      t.integer :unit_instock
      t.integer :unit_on_order
      t.decimal :unit_price, precision: 12, scale: 3
      t.boolean :discontinued
      t.text :desc
      t.string :image
      t.integer :category_id

      t.timestamps
    end
  end
end
