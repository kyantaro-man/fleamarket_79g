require 'rails_helper'
describe User do
  describe '#create' do

    it "nickname, email, password, password_confirmation, family_name, first_name, kana_family_name, kana_first_name, birth_year, birth_month, birth_dayが全て存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nicknameが空の場合は登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailが空の場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordが空の場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "password_confirmationが空の場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "family_nameが空の場合は登録できないこと" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it "first_nameが空の場合は登録できないこと" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "kana_family_nameが空の場合は登録できないこと" do
      user = build(:user, kana_family_name: "")
      user.valid?
      expect(user.errors[:kana_family_name]).to include("を入力してください")
    end

    it "kana_first_nameが空の場合は登録できないこと" do
      user = build(:user, kana_first_name: "")
      user.valid?
      expect(user.errors[:kana_first_name]).to include("を入力してください")
    end

    it "birth_yearが空の場合は登録できないこと" do
      user = build(:user, birth_year: "")
      user.valid?
      expect(user.errors[:birth_year]).to include("を入力してください")
    end

    it "birth_monthが空の場合は登録できないこと" do
      user = build(:user, birth_month: "")
      user.valid?
      expect(user.errors[:birth_month]).to include("を入力してください")
    end

    it "birth_dayが空の場合は登録できないこと" do
      user = build(:user, birth_day: "")
      user.valid?
      expect(user.errors[:birth_day]).to include("を入力してください")
    end

    it "emailが意図しない形式の場合は登録できないこと" do
      user = build(:user, email: "example@aa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "family_nameが半角の場合は登録できないこと" do
      user = build(:user, family_name: "ｱﾍﾞ")
      user.valid?
      expect(user.errors[:family_name]).to include("は不正な値です")
    end

    it "first_nameが半角の場合は登録できないこと" do
      user = build(:user, first_name: "ｼﾝｿﾞｳ")
      user.valid?
      expect(user.errors[:first_name]).to include("は不正な値です")
    end

    it "kana_family_nameがカタカナの場合は登録できないこと" do
      user = build(:user, kana_family_name: "アベ")
      user.valid?
      expect(user.errors[:kana_family_name]).to include("は不正な値です")
    end

    it "kana_first_nameがカタカナの場合は登録できないこと" do
      user = build(:user, kana_first_name: "シンゾウ")
      user.valid?
      expect(user.errors[:kana_first_name]).to include("は不正な値です")
    end

    it "passwordが７文字以上の場合は登録できること" do
      user = build(:user, password: "7777777", password_confirmation: "7777777")
      expect(user).to be_valid
    end

    it "passwordが６文字以下の場合は登録できないこと" do
      user = build(:user, password: "666666", password_confirmation: "666666")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "passwordが７文字以上でもpassword_confirmationと一致しない場合は登録できないこと" do
      user = build(:user, password: "7777777")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "重複したemailがある場合登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

  end
end