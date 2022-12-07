# frozen_string_literal: true

class Breview < ApplicationRecord
  belongs_to :bproduct
  belongs_to :user
end
