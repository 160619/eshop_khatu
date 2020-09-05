class AddAggregateRatingToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :aggregate_rating, :decimal, precision: 2, scale: 1
  end
end
