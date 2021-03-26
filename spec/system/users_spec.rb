require 'rails_helper'

RSpec.feature 'Users', type: :system do
  feature 'CREATE' do
    scenario 'is valid' do
      visit root_path
      fill_in 'ユーザー名', with: 'kenji'
      fill_in 'メールアドレス', with: 'kenji@example.com'
      fill_in 'パスワード(6文字以上)', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_button 'ユーザー登録'

      expect(page).to have_content '登録完了！'
    end
  end
  
  feature 'EDIT' do
    before do
      @user = User.create!(
        name: 'kenji',
        email: 'kenji@example.com',
        password: 'password',
        password_confirmation: 'password',
        profile: 'こんにちは',
      )
      sign_in @user
    end

    context 'when update name and profile' do
      scenario 'is valid' do
        visit edit_user_registration_path
        expect(page).to have_field 'ハンターの名前', with: 'kenji'
        fill_in 'ハンターの名前', with: 'Superman'
        fill_in '自己紹介文', with: 'Hello World!'
        click_button '更新する'

        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(page).to have_content 'Superman'
        expect(page).to have_content 'Hello World!'
      end
    end

    context 'when update email and login' do
      background do
        @old_email = 'kenji@example.com'
        @new_email = 'superman@example.com'
        visit edit_user_registration_path
        expect(page).to have_field 'メールアドレス', with: @old_email
        fill_in 'メールアドレス', with: @new_email
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        click_on 'logout-icon-link'
      end

      scenario 'is invalid if login with old_email' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: @old_email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
      end

      scenario 'is valid if login with new_email' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: @new_email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'when update profile image' do
      scenario 'is valid with new image' do
        visit edit_user_registration_path
        attach_file 'プロフィール画像', "#{Rails.root}/spec/factories/profile_image.png"
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(page).to have_selector("img[src$='profile_image.png']")

        visit edit_user_registration_path
        check 'user_remove_image'
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(page).to have_selector("img[src$='default-5f155e4654cd604e811fb074b3a32af28a3c47918eab81a476a8d075bb171d05.png']")
      end
    end
  end
end