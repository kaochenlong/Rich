require 'rails_helper'

RSpec.describe User, type: :model do
  it "可以註冊" do
    user = create(:user)
    expect(user.persisted?).to be true
  end

  it "無法註冊" do
    user = User.create(email: "cc@aa.cc", password: "123")
    expect(user.persisted?).to be false
    expect(user.errors.any?).to be true
    expect(user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
  end
end
