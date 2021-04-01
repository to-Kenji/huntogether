require 'rails_helper'

RSpec.describe 'Techniques', type: :system do
  describe 'from Signup to Create, Edit and Destroy technique' do
    it 'is valid' do
      visit new_user_registration_path
      fill_in 'ユーザー名', with: 'kenji'
      fill_in 'メールアドレス', with: 'kenji@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_button '登録'

      click_on '新規投稿'
      expect(page).to have_content '新規投稿'
      expect(page).to have_current_path new_technique_path, ignore_query: true

      fill_in 'technique_title', with: 'This is the title'
      select 'アルバトリオン', from: '対象モンスター：'
      select '片手剣', from: '使用武器：'
      fill_in 'technique_body', with: 'This is the body'
      fill_in 'YouTubeの共有リンクを貼り付けてください：', with: 'https://youtu.be/91vysrHZp0k'

      click_button '投稿'
      expect(page).to have_content 'This is the title'
      expect(page).to have_content 'This is the body'
      expect(page).to have_content 'アルバトリオン'
      expect(page).to have_content '片手剣'

      click_on 'technique-edit-icon'
      fill_in 'technique_title', with: 'Changed the title'
      select 'ミラボレアス', from: '対象モンスター：'
      select '大剣', from: '使用武器：'
      fill_in 'technique_body', with: 'Changed the body'
      fill_in 'YouTubeの共有リンクを貼り付けてください：', with: ''

      click_button 'この内容で保存'
      expect(page).to have_content 'Changed the title'
      expect(page).to have_content 'Changed the body'
      expect(page).to have_content 'ミラボレアス'
      expect(page).to have_content '大剣'
      expect(page).to have_content '動画はありません'

      click_on 'technique-edit-icon'
      click_on '投稿を削除'
      page.accept_confirm
      expect(page).to have_content '投稿を削除しました。'
      expect(page).to have_current_path root_path, ignore_query: true
      expect(page).not_to have_content 'Changed the title'
    end
  end
end
