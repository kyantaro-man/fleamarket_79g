class ApplicationController < ActionController::Base

before_action :basic_auth, if: :production?
before_action :authenticate_user!
before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [
    :nickname,
    :first_name,
    :family_name,
    :kana_first_name,
    :kana_family_name,
    :birth_year,
    :birth_month, 
    :birth_day,
    address_attributes: [
      :zip_code,
      :prefecture,
      :municipality,
      :address,
      :apartment_name,
      :phone_number,
      :user_id
    ]])
end

private

def basic_auth
  authenticate_or_request_with_http_basic do |username, password|
    username == Rails.application.credentials[:basic_auth][:user] &&
    password == Rails.application.credentials[:basic_auth][:pass]
  end
end

def production?
  Rails.env.production?
end

end

