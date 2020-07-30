class CardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def index
    if @card.present?
      Payjp.api_key = '秘密鍵'
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
  end

  def new
    card = Card.find_by(user_id: current_user.id)
    redirect_to action: "index" if card.present?
  end

  def create
    Payjp.api_key = '秘密鍵'
    
    if params['token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test', # 顧客情報の概要（なくてもいい）
        email: current_user.email,
        card: params['token'], # 顧客情報とカード情報のトークンを紐付ける
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy
    Payjp.api_key = '秘密鍵'
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  private

  def set_card
    @card = Card.find_by(user_id: current_user.id) if Card.where(user_id: current_user.id).present?
  end

end
