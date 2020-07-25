require 'rails_helper'
describe Address do
  describe '#create' do

    it "zip_code,prefecture,municipality,address,が全て存在すれば登録できること" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "zip_codeが空の場合は登録できないこと" do
      address = build(:address, zip_code: "")
      address.valid?
      expect(address.errors[:zip_code]).to include("を入力してください")
    end

    it "prefectureが空の場合は登録できないこと" do
      address = build(:address, prefecture: "")
      address.valid?
      expect(address.errors[:prefecture]).to include("を入力してください")
    end

    it "municipalityが空の場合は登録できないこと" do
      address = build(:address, municipality: "")
      address.valid?
      expect(address.errors[:municipality]).to include("を入力してください")
    end

    it "addressが空の場合は登録できないこと" do
      address = build(:address, address: "")
      address.valid?
      expect(address.errors[:address]).to include("を入力してください")
    end

    it "apartment_nameが空の場合は登録できること" do
      address = build(:address, apartment_name: "")
      expect(address).to be_valid
    end

    it "phone_numberが空の場合は登録できること" do
      address = build(:address, phone_number: "")
      expect(address).to be_valid
    end

    it "zip_codeが意図しない値(ハイフンなし)の場合は登録できないこと" do
      address = build(:address, zip_code: "1234567")
      address.valid?
      expect(address.errors[:zip_code]).to include("は不正な値です")
    end

  end
end