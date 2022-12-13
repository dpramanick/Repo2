# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'association' do
    it { should belong_to(:product) }
    it { should belong_to(:user) }
  end
end
