# frozen_string_literal: true

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

  describe Message do
    it 'confirm participant' do
      subject.room = nil
      expect(subject).to_not be_valid
    end

    it 'participant is absent' do
      subject.participant = nil
      expect(subject).to_not be_valid
    end
  end
end
