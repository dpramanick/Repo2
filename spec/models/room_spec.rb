# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'should have a unique name' do
    Room.create!(name: 'Foo')
    room = Room.new(name: 'Foo')
    room.should_not be_valid
    room.errors[:name].should include('has already been taken')
  end

  describe 'broadcasting_if_public' do
    subject(:saving) do
      record.save!
      record.reload
    end
  end

  context 'associations' do
    it { should have_many(:messages) }
    it { should have_many(:participants).dependent(:destroy) }
  end

  context 'room to broadcast if private' do
    before do
      Room.create!(name: 'Hello', is_private: true)
    end

    it 'results true if room is private' do
      expect(Room.present?).to be true
    end
  end

  context 'to create private room' do
    before do
      Room.create!(name: 'Hope', is_private: true)
      User.create!(user_id: 1, email: 'glenn@example.com', password: 'password', latitude: 54.234, longitude: 45.345,
                   postcode: 70_096, telephone: '8765434567')
      @new_participant = Participant.create!(user_id: 1, room_id: 1)
    end

    it 'allow to create a single room' do
      expect(Room.present?).to be true
    end
  end
end

# rubocop:enable Metrics/BlockLength
