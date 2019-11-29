class PurchasesController < ApplicationController
    require 'payjp'
    layout 'others_application'

    def index
     @useraddress = UserAddress.where(user_id: current_user.id)
     @product = Product.find(params[:product])
     card = CreditCard.where(user_id: current_user.id).first
      if card.blank?
       redirect_to new_card_path
        else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.cards.retrieve(card.card_id)
        @card_brand = @default_card_information.brand    
        case @card_brand
         when "Visa"
         @card_src = "visa.svg"
         when "JCB"
         @card_src = "jcb.svg"
         when "MasterCard"
         @card_src = "master-card.svg"
         when "American Express"
         @card_src = "american_express.svg"
         when "Diners Club"
         @card_src = "dinersclub.svg"
         when "Discover"
         @card_src = "discover.svg"
        end
      end
    end
  
  def cards
    @product = Product.find(params[:product])
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
      @card_brand = @default_card_information.brand    
      case @card_brand
      when "Visa"
        @card_src = "visa.svg"
      when "JCB"
        @card_src = "jcb.svg"
      when "MasterCard"
        @card_src = "master-card.svg"
      when "American Express"
        @card_src = "american_express.svg"
      when "Diners Club"
        @card_src = "dinersclub.svg"
      when "Discover"
        @card_src = "discover.svg"
      end
    end
  end

  def pay
    card = CreditCard.where(user_id: current_user.id).first
    @product = Product.find(params[:product])
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @product.price,
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    if @product.update(buyer_id: current_user.id)
      redirect_to done_purchases_path(product: @product)
    else
      redirect_to done_purchases_path(product: @product)
    end
  end
  
  def done
    @product = Product.find(params[:product])
    @useraddress = UserAddress.where(user_id: current_user.id)
  end

end
