class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_paramaters, if: :devise_controller?
  before_action :set_category_brand
  protect_from_forgery with: :null_session

  private

  def configure_permitted_paramaters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:registration_type,profile_attributes: [:nickname, :birthday, :first_name, :last_name, :first_name_kana, :last_name_kana, :name]])
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def set_category_brand
    @parents_category = Category.all.order("id ASC").limit(13)
    #2440:シャネル  3802:ナイキ  6142:ルイ ヴィトン  6758:シュプリーム  218:アディダス
    @parents_brand = Brand.where(id:[2440,3802,6142,6758,218])
  end

end