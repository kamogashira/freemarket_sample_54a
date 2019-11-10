class PurchasesController < ApplicationController
    require 'payjp'

    def index
     @useraddress = UserAddress.where(user_id: current_user.id)
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
  
    def destroy
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      if @card.destroy
        redirect_to action: "index", notice: "削除しました"
      else
        redirect_to action: "index", alert: "削除できませんでした"
      end
    end

  def pay
    card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => 1200,
    # :amount => @product.price,
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    redirect_to action: 'done'
  end
  
  def done
    @useraddress = UserAddress.where(user_id: current_user.id)
  end

end
