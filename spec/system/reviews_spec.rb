require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:event) { FactoryBot.create(:event) }

  before do
    sign_in user
    visit events_path
  end

  scenario "ユーザーはイベントに対してレビューができる" do
    visit user_event_path(user, event)
    expect {
      choose "star5"
      fill_in "コメント", with: "とてもよかったです。"
      click_button "投稿"
    }.to change(event.reviews, :count).by(1)

    expect(page).to have_content "レビューを投稿しました。"
    expect(page).to have_content "とてもよかったです。"
  end
end
