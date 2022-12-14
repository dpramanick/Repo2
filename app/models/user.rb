# frozen_string_literal: true

# rubocop:disable Style/Documentation, Layout/HashAlignment

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :products, dependent: :destroy
  has_many :reviews
  has_many :messages

  validates :latitude, numericality: { greater_than_or_equal_to: -89.999, less_than_or_equal_to: 89.999 }
  validates :longitude, numericality: { greater_than_or_equal_to: -89.999, less_than_or_equal_to: 89.999 }
  validates_format_of :postcode, with: /\A\d{5}-\d{4}|\A\d{5}\z/, message: 'should be 12345 or 12345-1234'
  validates :telephone, length: { minimum: 10 },
             format: { with: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/ }

  scope :all_except, ->(user) { where.not(id: user) }

  after_create_commit { broadcast_append_to 'users' }

  def self.from_omniauth(auth)
    where(provider: auth.provider, user_id: auth.user_id).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar_url = auth.info.image
    end
  end
end

# rubocop:enable Style/Documentation, Layout/HashAlignment
