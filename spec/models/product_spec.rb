require 'rails_helper'

describe Product do
  describe '#index' do

    it "is invalid with a name more than 40 characters" do
      name = Faker::String.random(length: 41)
      product = build(:product, name: name)
      product.valid?
      expect(product).to_not be_valid
    end

    it "is valid without a brand_id" do
      product = build(:product, brand_id: nil)
      product.valid?
      expect(product).to be_valid
    end

    it "is invalid with a description more than 1000 characters" do
      description = Faker::String.random(length: 1001)
      product = build(:product, description: description)
      product.valid?
      expect(product).to_not be_valid
    end

    it "is invalid with a price with a decimal" do
      price = Faker::Number.decimal(l_digits: 1)
      product = build(:product, price: price)
      product.valid?
      expect(product).to_not be_valid
    end

    it "is invalid with a price less than 300" do
      price = Faker::Number.within(range: 1..299)
      product = build(:product, price: price)
      product.valid?
      expect(product).to_not be_valid
    end

    it "is valid with a price more than 300 and less than 9999999" do
      price = Faker::Number.within(range: 300..9999999)
      product = build(:product, price: price)
      product.valid?
      expect(product).to be_valid
    end

  end
end