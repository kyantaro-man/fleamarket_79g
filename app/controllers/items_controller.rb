class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item_image = @item.item_images.build
  end

  def create
    Item.create(item_params)
    if @item.save

      params[:item_images]['image'].each do |img|
        @item_image = @item.item_images.create(:image => img, :item_id => @item.id)
      end

      redirect_to item_path(@item.id)
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :category_id, :brand, :condition_id, :postageplayer_id, :shippingdate_id, :price, :introduction, :buyer_id, :prefecture_id, item_images_attributes: [:id, :item_id, :image])
  end  
end
