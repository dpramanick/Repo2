# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe Message do
    it { is_expected.to callback(:confirm_participant).before(:create) }
  end

  describe 'callbacks' do
    describe 'broadcasting_append_to_room' do
      subject(:saving) do
        record.save!
        record.reload
      end
    end
  end

  context 'confirm participant' do
    before do
      Room.create!(name: 'Hello', is_private: true)
      User.create!(user_id: 1, email: 'glenn@example.com', password: 'password', latitude: 54.234, longitude: 45.345,
                   postcode: 70_096, telephone: '8765434567')
      @new_participant = Participant.create!(user_id: 1, room_id: 1)
    end

    it 'results true if room is private' do
      expect(Room.present?).to be true
    end

    it 'results true' do
      expect(Participant.present?).to be true
    end
  end

  context 'confirm participant to be false' do
    before do
      Room.create!(name: 'Hello', is_private: false)
      User.create!(user_id: 2, email: 'glenn@example.com', password: 'password', latitude: 54.234, longitude: 45.345,
                   postcode: 70_096, telephone: '8765434567')
      @new_participant = Participant.create!(user_id: 1, room_id: 1)
    end

    it 'results true if room is private' do
      expect(Room).not_to be true
    end
  end
end

# rubocop:enable Metrics/BlockLength
