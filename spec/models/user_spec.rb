require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.new(
      name: 'kenji',
      email: 'kenji@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  }

  let(:user2) {
    User.new(
      name: 'kazuki',
      email: 'kazuki@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  }

  describe 'POST #create' do
    context 'when validation success' do
      it 'is valid' do
        expect(user).to be_valid
        expect { user.save }.to change { User.count }.by(1)
      end
    end

    context 'when validation failed' do
      context 'when name is brank' do
        it 'is invalid' do
          user.name = nil
          expect(user).not_to be_valid
          expect(user.errors[:name]).to include('を入力してください')

          user.name = ''
          expect(user).not_to be_valid
          expect(user.errors[:name]).to include('を入力してください')

          user.name = ' '
          expect(user).not_to be_valid
          expect(user.errors[:name]).to include('を入力してください')
        end
      end

      context 'when name is more than 16 characters' do
        it 'is invalid' do
          user.name = 'a' * 16
          expect(user).not_to be_valid
          expect(user.errors[:name]).to include('は15文字以内で入力してください')
        end
      end

      context 'when password and password-confirmation does not match' do
        it 'is invalid' do
          user.password_confirmation = 'wrongpassword'
          expect(user).not_to be_valid
          expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
        end
      end

      context 'when password is less than 6 characters' do
        it 'is invalid' do
          user.password = 'pass'
          user.password_confirmation = 'pass'
          expect(user).not_to be_valid
          expect(user.errors[:password]).to include('は6文字以上で入力してください')
        end
      end

      context 'when using the same email with another account' do
        it 'is invalid' do
          user.save
          another_user = User.new(
            name: 'another_user',
            email: user.email,
            password: 'password',
            password_confirmation: 'password'
          )
          expect(another_user).not_to be_valid
          expect(another_user.errors[:email]).to include('はすでに存在します')
        end
      end
    end
  end

  describe 'instanse method of User' do
    let(:weapon) { create(:weapon) }
    let(:monster) { create(:monster) }

    before do
      user.save
      user2.save
      @technique = Technique.create(
        title: 'TITLE',
        body: 'BODY',
        user_id: user.id,
        weapon_id: weapon.id,
        monster_id: monster.id,
        youtube_url: ''
      )
      Like.create(user_id: user2.id, technique_id: @technique.id)
    end

    describe 'about Like' do
      it 'is valid if already liked technique' do
        expect(user2.already_liked?(@technique)).to be_truthy
      end
    end

    describe 'about Bookmark' do
      context 'when favorite' do
        it 'is valid' do
          expect(user2.favorite(@technique)).to be_valid
          expect(user2.already_favorited?(@technique)).to be_truthy
        end
      end

      context 'when unfavorite' do
        it 'is valid' do
          user2.favorite(@technique)
          expect(user2.unfavorite(@technique)).to be_valid
          expect(user2.already_favorited?(@technique)).to be_falsey
        end
      end
    end

    describe 'about Follow, UnFollow' do
      context 'when follow' do
        it 'is valid' do
          expect(user2.follow(user)).to be_valid
          expect(user2.following?(user)).to be_truthy
        end
      end

      context 'when unfollow' do
        it 'is valid' do
          user2.follow(user)
          expect(user2.unfollow(user)).to be_valid
          expect(user2.following?(user)).to be_falsey
        end
      end
    end
  end
end
