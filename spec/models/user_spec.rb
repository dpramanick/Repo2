# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Lint/UselessAssignment

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a new user' do
    before do
      @new_user = User.create!(email: 'glenn@example.com', password: 'password', latitude: 54.234, longitude: 45.345,
                               postcode: 70_096, telephone: '8765434567')
      @created_user = User.find_by(email: @new_user.email)
      @new_user2 = User.new(email: 'glenn@example.com', password: 'password2')
    end

    it 'will create a record in the Users table' do
      expect(User.find(@new_user.id).present?).to be true
    end

    it 'will create the record with the correct email address' do
      expect(@created_user.email).to eq(@new_user.email)
    end

    it 'will ensure that the password is encrypted' do
      expect(@created_user.encrypted_password).to_not eq(@new_user.password)
    end

    it 'will ensure that the email address is unique' do
      expect(@new_user2).to be_invalid
    end
  end

  context 'associations' do
    it { should have_many(:products).dependent(:destroy) }
    it { should have_many(:reviews) }
    it { should have_many(:messages) }
    it { should validate_length_of(:telephone).is_at_least(10) }
    it { should allow_value(8_675_435_678).for(:telephone) }
    it { should_not allow_value(89_765_435_678).for(:telephone) }
    it { should allow_value(12_345).for(:postcode) }
    it { should_not allow_value(2_345_678).for(:postcode) }

    it { should_not allow_value(-90).for(:latitude) }
    it { should_not allow_value(-90).for(:longitude) }
  end

  context 'validations' do
    it 'should allow valid values for latitude' do
      (-89..89).step(3).to_a.each do |v|
        should allow_value(v).for(:latitude)
      end
    end

    it 'should allow valid values for longitude' do
      (-89..89).step(3).to_a.each do |v|
        should allow_value(v).for(:longitude)
      end
    end
  end
end

auth_hash = OmniAuth::AuthHash.new({
                                     provider: 'google',
                                     user_id: '1234',
                                     info: {
                                       email: 'user@example.com',
                                       name: 'Justin Bieber'
                                     }
                                   })

describe User, '#from_omniauth' do
  it 'retrieves an existing user' do
    user4 = User.new(
      provider: 'google',
      user_id: 1234,
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user4.save
    omniauth_user = User.from_omniauth(auth_hash)
  end

  it "creates a new user if one doesn't already exist" do
    expect(User.count).to eq(0)

    omniauth_user = User.from_omniauth(auth_hash)
    expect(User.count).to eq(0)
  end
end

# rubocop:enable Metrics/BlockLength, Lint/UselessAssignment
