# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :comments

  validates :rating, inclusion: {in: [1, 2, 3, 4, 5]}
  validates :content, length: {in: 4..1000}
end
