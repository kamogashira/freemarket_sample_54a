class CardsController < ApplicationController
  require "payjp"

  def new
    card = CreditCard.where(user_id: current_user.id)
    redirect_to root_path if card.exists?
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save!
        redirect_to users_sign_up_complete_path
      else
        redirect_to new_card_path
      end
    end
  end
end