# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'registrations_application'

  before_action :configure_sign_in_params, only: [:create]
  before_action :recaptcha,  only: [:create]
    
    def create
      super
      if verify_recaptcha(model: @user) && @user.save
      @user.save
      end
    end

  protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [:email, :password,])
    end

    def recaptcha
    self.resource = resource_class.new sign_in_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
      end
    end
end
