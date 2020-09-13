# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :body, presence: true, length: {in: 4..1000}

  belongs_to :review
end
