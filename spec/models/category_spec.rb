require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.create(:category) }

  it "ファクトリーが正常に動く" do
    expect(FactoryBot.build(:category)).to be_valid
  end

  it "正常な値を入力すると、カテゴリーが作成できる" do
    ategory = Category.new(
      name: "スポーツ"
    )
    expect(category).to be_valid
  end

  describe "バリデーションのテスト" do
    it "カテゴリー名は必須である" do
      category.name = " "
      expect(category).to_not be_valid
    end
  end
end
