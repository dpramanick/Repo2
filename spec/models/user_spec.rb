require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a new user' do
    before do
      @new_user = User.create!(email: 'glenn@example.com', password: 'password')
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
end