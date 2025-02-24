require 'rails_helper'

RSpec.describe "イベント機能", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:category, name: "趣味") }

  before do
    sign_in user
    visit root_path
  end

  scenario "既存のカテゴリーを選択してイベントを作成できる" do
    expect {
      click_link "イベント作成"
      fill_in "タイトル", with: "映画鑑賞会"
      fill_in "説明文", with: "みんなでドラえもんを鑑賞しましょう！"
      fill_in "開催日時", with: "2025-10-10 12:00:00"
      fill_in "開催場所", with: "各家庭"
      select "趣味", from: "カテゴリーを選択"
      click_button "作成"

      aggregate_failures do
        expect(page).to have_content "イベントを作成しました。"
        expect(page).to have_content "映画鑑賞会"
        expect(page).to have_content "#{user.name}"
        expect(page).to have_content "趣味"
      end
    }.to change(user.events, :count).by(1)
  end

  scenario "新しいカテゴリーを作成し、イベントを作成できる" do
    expect {
      click_link "イベント作成"
      fill_in "タイトル", with: "オンライン飲み会"
      fill_in "説明文", with: "オンラインで飲み会を開きます。"
      fill_in "開催日時", with: "2025-10-10 20:00:00"
      fill_in "開催場所", with: "各家庭"
      fill_in "新しいカテゴリーを作成", with: "飲み会"
      click_button "作成"

      aggregate_failures do
        expect(page).to have_content "イベントを作成しました。"
        expect(page).to have_content "オンライン飲み会"
        expect(page).to have_content "#{user.name}"
        expect(page).to have_content "飲み会"
      end
    }.to change(user.events, :count).by(1)
  end
end
