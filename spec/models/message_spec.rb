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
end
