class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :item_image, :seller, :category, :brand, :size, :condition, :postage_player, :postage_type, :shipping_date, :price, :introduction, :buyer, :prefecture_id)
  end  
end
