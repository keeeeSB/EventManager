require 'rails_helper'

RSpec.describe "Participations", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:event) { FactoryBot.create(:event, user: other_user) }

  before do
    sign_in user
    visit events_path
  end

  scenario "ユーザーは他ユーザーが作成したイベントに対して、参加申し込みができる" do
    expect {
      click_link "参加申し込み"
    }.to change(event.participations, :count).by(1)

    expect(page).to have_content "参加申し込みを行いました。"
    expect(current_path).to eq events_path
  end
end
