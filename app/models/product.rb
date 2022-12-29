# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :condition
  belongs_to :category
  has_one_attached :picture
  has_many :reviews

  validates :category_id, presence: true

  scope :search, ->(search) { joins(:category).where('categories.name like ?', "%#{search}%").distinct }
  scope :condition_id, ->(condition_id) { where condition_id: condition_id }
  scope :category_id, ->(category_id) { where category_id: category_id }
  scope :is_approved, ->(approve) { where is_approved: approve }
  scope :newest_first, -> { order(created_at: :desc) }
end
