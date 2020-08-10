require 'rails_helper'
describe Image do
  describe '#create' do
    # presence: true 
    it "is valid with a image" do
      item = build(:item)
      image = build(:image)
      expect(image).to be_valid
    end
    
    it "imageが空の場合は登録できないこと" do
      image = build(:image, src:"")
      image.valid?
      expect(image.errors[:image]).to include()
    end
  end
end