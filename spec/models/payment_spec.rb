# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  context 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end
end
