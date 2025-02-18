require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it "ファクトリーが正常に動く" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "正常な値を入力すると、ユーザーが作成できる" do
    user = User.new(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password"
    )
    expect(user).to be_valid
  end

  describe "バリデーションのテスト" do
    it "お名前は必須である" do
      user.name = " "
      expect(user).to_not be_valid
    end
  end
end
