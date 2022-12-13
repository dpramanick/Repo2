# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    described_class.new(name: 'Guitar')
  end

  context 'associations' do 
    it { should have_many(:products) }
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  context 'when creating a category' do
    before do
      @new_category = Category.create!(name: 'Drum')
      @new_category2 = Category.new(name: 'Drum')
    end

    it 'will ensure that name is unique' do
      expect(@new_category2).to_not be_valid
    end
  end
end
