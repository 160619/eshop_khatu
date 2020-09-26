# frozen_string_literal: true

class Product < ActiveRecord::Base
  validates :product_name, presence: true, length: { minimum: 5 }
  validates :quantity, presence: true
  validates :unit_price, presence: true

  belongs_to :category
  has_many :reviews, dependent: :destroy

  def calculate_rating
    avg_review = self.reviews.average(:rating).round(2)
    self.update(aggregate_rating: avg_review)
  end
end
