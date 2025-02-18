require 'rails_helper'

RSpec.describe Category, type: :model do
  it "ファクトリーが正常に動く" do
    expect(FactoryBot.build(:category)).to be_valid
  end
end
