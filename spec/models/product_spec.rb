# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

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

  context 'category scope' do
    before do
      Category.create!(name: 'Guitar')
      Condition.create!(name: 'Good')
      @new_product = Product.create!(name: 'Nexa', condition_id: 1, category_id: 1, price: 500)
    end

    it 'includes products with category' do
      expect(Product.category_id(1)).to include(@new_product)
    end

    it 'excludes products with category' do
      expect(Product.category_id(5)).not_to include(@new_product)
    end
  end

  context 'condition scope' do
    before do
      Category.create!(name: 'Drum')
      Condition.create!(name: 'Poor')
      @new_product2 = Product.create!(name: 'Caramel', condition_id: 1, category_id: 1, price: 500)
    end

    it 'includes products with condition' do
      expect(Product.condition_id(1)).to include(@new_product2)
    end

    it 'excludes products with condition' do
      expect(Product.condition_id(6)).not_to include(@new_product2)
    end
  end

  context 'search scope' do
    before do
      Category.create!(name: 'Amplifiers')
      Condition.create(name: 'Excellent')
      binding.pry
      @new_product3 = Product.create!(name: 'Cumil', condition_id: 1, category_id: 1, price: 500)
    end

    it 'performs search' do
      expect(Product.search(1)).to include(@new_product3)
    end
  end

  context 'picture attached scope' do
    it 'is valid if image is attached' do
      file = Rails.root.join('spec', 'fixtures', 'images', 'product_item', 'photo.jpg')

      product_item = Product.new
      expect(product_item.invalid?).to eq true
    end
  end
end

# rubocop:enable Metrics/BlockLength
