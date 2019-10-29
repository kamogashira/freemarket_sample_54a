require 'rails_helper'

RSpec.describe Comment do
  describe '#create' do

    it "is invalid without a user_id" do
      comment = build(:comment, user_id: nil)
      comment.valid?
      expect(comment).to_not be_valid
    end

    it "is invalid without a product_id" do
      comment = build(:comment, product_id: nil)
      comment.valid?
      expect(comment).to_not be_valid
    end

  end
end
