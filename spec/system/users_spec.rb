require 'rails_helper'

RSpec.feature 'Users', type: :system do
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

  feature 'EDIT' do
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
      
    end
  end
end