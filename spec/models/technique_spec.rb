require 'rails_helper'

RSpec.describe Technique, type: :model do
  let(:user) { create(:user) }
  let(:weapon) { create(:weapon) }
  let(:monster) { create(:monster) }
  let(:technique) {
    Technique.new(
      title: 'TITLE',
      body: "BODY",
      user_id: user.id,
      weapon_id: weapon.id,
      monster_id: monster.id,
      youtube_url: "https://www.youtube.com/watch?v=-YG2pgoghVA",
    )
  }

  describe 'POST #create' do
    context 'when validation success' do
      it 'is valid' do
        expect(technique).to be_valid
        expect{ technique.save }.to change{ Technique.count }.by(1)
      end
    end

    context 'when validation error' do
      it 'is invalid with no title' do
        technique.title = ''
        expect(technique).not_to be_valid
        expect(technique.errors[:title]).to include('を入力してください')
        technique.title = ' '
        expect(technique).not_to be_valid
        expect(technique.errors[:title]).to include('を入力してください')
        technique.title = nil
        expect(technique).not_to be_valid
        expect(technique.errors[:title]).to include('を入力してください')
      end

      it 'is invalid with no monster' do
        technique.monster_id = ''
        expect(technique).not_to be_valid
        expect(technique.errors[:monster]).to include('を入力してください')
      end

      it 'is invalid with no user' do
        technique.user_id = ''
        expect(technique).not_to be_valid
      end

      it 'is invalid with no weapon' do
        technique.weapon_id = ''
        expect(technique).not_to be_valid
        expect(technique.errors[:weapon]).to include('を入力してください')
      end

      it 'is invalid with no body' do
        technique.body = ''
        expect(technique).not_to be_valid
        expect(technique.errors[:body]).to include('を入力してください')
        technique.body = ' '
        expect(technique).not_to be_valid
        expect(technique.errors[:body]).to include('を入力してください')
        technique.body = nil
        expect(technique).not_to be_valid
        expect(technique.errors[:body]).to include('を入力してください')
      end

      it 'is invalid with more than 44 characters of youtube_url' do
        technique.youtube_url = "https://www.youtube.com/watch?v=-YG2pgoghVAa"
        expect(technique).not_to be_valid
        expect(technique.errors[:youtube_url]).to include('は43文字以内で入力してください')
      end
      
      it 'is invalid with youtube_url regex' do
        technique.youtube_url = "aaa://www.youtube.com/watch?v=-YG2pgoghVA"
        expect(technique).not_to be_valid
        expect(technique.errors[:youtube_url]).to include('は不正な値です')

        technique.youtube_url = "https://www.<>.com/watch?v=-YG2pgoghVA"
        expect(technique).not_to be_valid
        expect(technique.errors[:youtube_url]).to include('は不正な値です')

        technique.youtube_url = "https://www.youtube.comwatch?v=-YG2pgoghVA"
        expect(technique).not_to be_valid
        expect(technique.errors[:youtube_url]).to include('は不正な値です')
      end
    end
  end
end