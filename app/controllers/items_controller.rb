class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else

      render :new
     end
  end

  def show    #商品詳細ページ
    # @item = Item.find(params[:id])   商品の投稿ができてから😄
  end

  def buy
    #商品・ユーザー・カードの変数を決めています
    @card = Card.find_by(user_id: current_user.id) if Card.where(user_id: current_user.id).present?
    @address = Address.find_by(user_id: current_user.id)
    @item = Item.find(params[:id])
    #Payjpの秘密鍵を取得しています
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    #Payjpから顧客情報を取得しています
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @card_information = customer.cards.retrieve(@card.card_id)
    @card_brand = @card_information.brand
    case @card_brand
    when "Visa"
      @card_src = "visa.gif"
    when "MasterCard"
      @card_src = "master.gif"
    when "JCB"
      @card_src = "jcb.gif"
    when "American Express"
      @card_src = "amex.gif"
    when "Diners Club"
      @card_src = "diners.gif"
    when "Discover"
      @card_src = "dc.gif"
    end
  end
  #↑同じ記述がcardsコントローラにもあります

  def purchase
    @card = Card.find_by(user_id: current_user.id)
    @item = Item.find(params[:id])

    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]

    charge = Payjp::Charge.create(
      amount: @item.price,
      customer: Payjp::Customer.retrieve(@card.customer_id),
      currency: 'jpy'
    )

    @item_buyer = Item.find(params[:id])
    @item_buyer.update(buyer_id: current_user.id)
    redirect_to purchased_item_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category_id, :brand, :condition_id, :postageplayer_id, :shippingdate_id, :price, :introduction, :buyer_id, :prefecture_id, images_attributes: [:src])
  end  
  
end
