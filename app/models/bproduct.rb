# frozen_string_literal: true

class Bproduct < ApplicationRecord
  validates :category_id, presence: true
  belongs_to :user, optional: true
  belongs_to :condition
  belongs_to :category
  has_one_attached :picture
  has_many :reviews

  scope :search, ->(search) { where('name like ?', "%#{search}%") }
  scope :search, ->(search) { joins(:category).where('categories.name like ?', "%#{search}%").distinct }
  scope :condition_id, ->(condition_id) { where condition_id: condition_id }
  scope :category_id, ->(category_id) { where category_id: category_id }
end
