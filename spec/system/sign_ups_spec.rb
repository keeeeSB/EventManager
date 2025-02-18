require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  include ActiveJob::TestHelper

  scenario "ユーザーは新規登録をすると、本人確認用のメールが送信される" do
    visit root_path
    click_link "新規登録"

    expect {
      fill_in "お名前", with: "テストユーザー"
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード再確認", with: "password"
      click_button "登録"
    }.to change(User, :count).by(1)

    expect(page).to \
      have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
    expect(current_path).to eq root_path

    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail.to).to eq [ "test@example.com" ]
      expect(mail.from).to eq [ "support@example.com" ]
      expect(mail.subject).to eq "メールアドレス確認メール"
      expect(mail.body).to match "ようこそ"
    end
  end

  scenario "本人確認用メールのリンクをクリックすると、アカウントを有効化できる" do
    user = User.create!(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password",
      confirmation_token: "sample_token",
      confirmation_sent_at: Time.current
    )

    visit user_confirmation_url(confirmation_token: user.confirmation_token)

    expect(page).to have_content "メールアドレスが確認できました。"
    expect(user.reload.confirmed?).to be true
  end
end
