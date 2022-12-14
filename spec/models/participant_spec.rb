# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  context 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end
end
