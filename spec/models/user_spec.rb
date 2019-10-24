require "rails_helper"
describe User do
  describe "#create" do
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid email without XXX@YYYY " do
      user = build(:user, email: "aaaaaaa")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    it "is invalid email with XXX@ " do
      user = build(:user, email: "xxxxx@")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    it "is invalid email with @YYY " do
      user = build(:user, email: "@yyyyy")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "is invalid different confirm_password" do
      user = build(:user, password_confirmation: "0000000b")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end