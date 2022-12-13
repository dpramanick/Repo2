# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Condition, type: :model do
  subject do 
    described_class.new(name: 'Good')
  end

  context 'associations' do 
    it { should have_many(:products) }
  end
end
