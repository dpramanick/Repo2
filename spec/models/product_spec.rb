# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject do
    described_class.new(category_id: 1)
  end

  context 'associations' do
    it { should have_many(:reviews) }
    it { should have_one_attached(:picture) }
    it { should belong_to(:condition) }
    it { should belong_to(:category) }
    it { should belong_to(:user).optional(true) }
  end

  it 'is not valid without a category_id' do
    subject.category_id = nil
    expect(subject).to_not be_valid
  end
end
