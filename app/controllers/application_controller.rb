class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :set_category_brand

  # before_action :basic_auth

  private

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
    @parents_brand = Brand.all.order("id ASC").limit(4)
  end

end