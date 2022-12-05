# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :product
  belongs_to :bproduct
  belongs_to :user
end
