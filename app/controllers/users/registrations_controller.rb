# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  def new
    @user = User.new
  end
  # GET /resource/sign_up
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?                                                               #送られたパラメーターがバリデーションに違反しているかをチェック
      flash.now[:alert] = @user.errors.full_messages 
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}                          #sessionに値をハッシュの形で保持
    session["devise.regist_data"][:user]["password"] = params[:user][:password]       #パスワードをsessionに代入
    @address = @user.build_address                                                    #userに紐づくaddressモデルのインスタンスを@addressに代入
    render :new_address
  end


  def create_address
    @user = User.new(session["devise.regist_data"]["user"])                            #sessionが保持してるuser情報を@userに代入
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)                                           #バリデーションが完了した情報とsessionで保持していた情報をユーザー情報に代入
    session["address"] = @address.attributes
    @card = @user.cards.build
    #以下の記述はcreate_cardに移しました
    # @user.save
    # session["devise.regist_data"]["user"].clear                                        #clearでsessionを削除
    # sign_in(:user, @user)
    render :new_card
  end

  def create_card
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(session["address"])
    Payjp.api_key = '秘密鍵'
    if params['token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test', # 顧客情報の概要（なくてもいい）
        email: @user.email,
        card: params['token'] # 顧客情報とカード情報のトークンを紐付ける
      )
    end
    @card = Card.new
    @card[:customer_id] = customer.id
    @card[:card_id] = customer.default_card
    unless @card.valid?
      flash.now[:alert] = @card.errors.full_messages
      render :new_card and return
    end
    @user.build_address(@address.attributes)
    @user.cards.build(@card.attributes)
    if @user.save
      session["devise.regist_data"]["user"].clear                                        #clearでsessionを削除
      sign_in(:user, @user)
    else
      render :new
    end
  end


  protected

  def address_params
    params.require(:address).permit(:zip_code, :prefecture, :municipality, :address, :apartment_name, :phone_number)
  end

  def card_params
    params.permit(:authenticity_token, :token)
  end
  # def card_params
  #   params.permit(:authenticity_token, :token)
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
