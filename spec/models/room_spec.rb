# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  context 'when adding users to a room' do
    before do
      @user = User.create!(email: 'glenn@example.com', password: 'password')
      @room = Room.create!(topic: 'Test')
    end

    it 'will contain the user' do
      @room.add_user(@user)
      expect(@room.includes_user?(@user)).to be true
    end
  end
end
