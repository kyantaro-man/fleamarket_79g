require 'rails_helper'
describe Item do
  describe '#create' do
  
    # presence: true 
    it "is valid with a item_name, category_id, condition_id, postageplayer_id, prefecture_id, shippingdate_id, price, introduction" do
      user = build(:user)
      item = create(:item)
      expect(item).to be_valid
    end

    it "item_nameが空の場合は登録できないこと" do
      item = build(:item, item_name: "")
      item.valid?
      expect(item.errors[:item_name]).to include("を入力してください")
    end

    it "category_idが空の場合は登録できないこと" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    it "condition_idが空の場合は登録できないこと" do
      item = build(:item, condition_id: "")
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "postageplayer_idが空の場合は登録できないこと" do
      item = build(:item, postageplayer_id: "")
      item.valid?
      expect(item.errors[:postageplayer_id]).to include("を入力してください")
    end

    it "prefecture_idが空の場合は登録できないこと" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "shippingdate_iddが空の場合は登録できないこと" do
      item = build(:item, shippingdate_id: "")
      item.valid?
      expect(item.errors[:shippingdate_id]).to include("を入力してください")
    end

    it "priceが空の場合は登録できないこと" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "introductionが空の場合は登録できないこと" do
      item = build(:item, introduction: "")
      item.valid?
      expect(item.errors[:introduction]).to include("を入力してください")
    end
    
     # max length
    it "item_nameが40文字以上は登録できないこと" do
      item = build(:item, item_name: "a" * 41)
      item.valid?
      expect(item.errors[:item_name]).to include("は40文字以内で入力してください")
    end
    
    it "introductionが1000文字以上は登録できないこと" do
      item = build(:item, introduction: "a" * 1001)
      item.valid?
      expect(item.errors[:introduction]).to include("は1000文字以内で入力してください")
    end

    it "item_nameが40文字以内は登録できること " do
      item = build(:item, item_name: "a" * 40)
      expect(item).to be_valid
     end
 
    it "introductionが1000文字以内は登録できること " do
      item = build(:item, introduction: "a" * 1000)
      expect(item).to be_valid
     end

  end
end