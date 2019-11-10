# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'registrations_application'

  before_action :configure_sign_in_params, only: [:create]
  # before_action :recaptcha,  only: [:create]
  
  protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [:email, :password,])
    end

    # def recaptcha
    #   if verify_recaptcha
    #   else
    #     flash.now[:recaptcha_error] = I18n.t('recaptcha.errors.verification_failed')
    #     return render action: :new
    #   end
    # end
end
