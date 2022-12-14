# frozen_string_literal: true

# rubocop:disable Style/Documentation

class Product < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :condition
  belongs_to :category
  has_one_attached :picture
  has_many :reviews

  validates :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate :correct_picture_type

  scope :search, ->(search) { joins(:category).where('categories.id like ?', "%#{search}%").distinct }
  scope :condition_id, ->(condition_id) { where condition_id: condition_id }
  scope :category_id, ->(category_id) { where category_id: category_id }
  scope :is_approved, ->(approve) { where is_approved: approve }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :user_id, ->(user_id, person) { where(user_id: user_id, person: person) }

  private

  def correct_picture_type
    return unless picture.attached? && !picture.content_type.in?(%w[picture/jpg picture/png])

    errors.add(:picture, 'must be a JPG or PNG')
  end
end

# rubocop:enable Style/Documentation
