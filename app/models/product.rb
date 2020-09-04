# frozen_string_literal: true

class Product < ActiveRecord::Base
  validates :product_name, presence: true, length: { minimum: 5 }
  validates :quantity, presence: true
  validates :unit_price, presence: true

  belongs_to :category
  has_many :reviews
end
