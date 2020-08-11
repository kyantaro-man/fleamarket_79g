class ItemsController < ApplicationController
  before_action :move_to_login_session, except: [:show, :index]
  before_action :move_to_root_path, only: [:update, :destroy, :edit]
  before_action :set_card, except: :show
  before_action :set_item, only: [:edit, :update,:show, :destroy, :buy, :purchase]

  def index
    @items = Item.all.includes(:user)
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
      @item.images.new
      render :new
    end
    
  end


  def show    #商品詳細ページ
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end
  

  def edit
  end


  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  
 

  def destroy
    if @item.destroy
      redirect_to root_path, notice: '商品を削除しました'
    else
      render :edit
    end

  end

  def buy
    @address = Address.find_by(user_id: current_user.id)
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

  def set_card
    @card = Card.find_by(user_id: current_user.id) if Card.where(user_id: current_user.id).present?
  end

  def set_item
    @item = Item.find(params[:id])
  end


  def item_params
    params.require(:item).permit(:item_name, :category_id, :brand, :condition_id, :postageplayer_id, :shippingdate_id, :price, :introduction, :buyer_id, :prefecture_id, images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
  end  

  def move_to_login_session
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

  def move_to_root_path
    unless @item.user == current_user
      redirect_to root_path
    end
  end
  
end
