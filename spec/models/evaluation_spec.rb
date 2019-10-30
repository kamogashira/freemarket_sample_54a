require 'rails_helper'

RSpec.describe Evaluation do

  it "is invalid without a user_id" do
    evaluation = build(:evaluation, user_id: nil)
    evaluation.valid?
    expect(evaluation).to_not be_valid
  end

  it "is invalid without a product_id" do
    evaluation = build(:evaluation, product_id: nil)
    evaluation.valid?
    expect(evaluation).to_not be_valid
  end

  it "is valid without a comment" do
    evaluation = build(:evaluation, comment: nil)
    evaluation.valid?
    expect(evaluation).to be_valid
  end

end
