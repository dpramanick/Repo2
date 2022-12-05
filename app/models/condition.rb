# frozen_string_literal: true

class Condition < ApplicationRecord
  has_many :products
  has_many :bproducts
end
