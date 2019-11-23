class Users::RegistrationsController < Devise::RegistrationsController
  layout 'registrations_application'

  before_action :save_new_to_session, only: :phone
  before_action :save_phone_to_session, only: :address
  
  def new
    @user = User.new
    @user.build_user_address
  end

  def SNS
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
    )
    @user.build_user_address
  end

  def save_new_to_session
    session[:user_params] = user_params
    session[:user_address_attributes_after_new] = user_params[:user_address_attributes]
    @user = User.new(session[:user_params])
    @user.build_user_address(session[:user_address_attributes_after_new])
    render 'devise/registrations/new' unless @user.valid?(:new_registration)
  end

  def step
    params[:user][:birthday] = birthday_join
    session[:user_params] = user_params
    session[:user_address_attributes_after_new] = user_params[:user_address_attributes]
    @user = User.new(session[:user_params])
    @user.build_user_address(session[:user_address_attributes_after_new])
    render 'devise/registrations/SNS' unless @user.valid?
  end

  def index
  end

  def phone
    params[:user][:birthday] = birthday_join
    session[:user_params] = user_params
    @user = User.new
    @user.build_user_address
    # if verify_recaptcha
    # else
    #   flash.now[:recaptcha_error] = I18n.t('recaptcha.errors.verification_failed')
    #   return render action: :new
    # end
  end

  def save_phone_to_session
    session[:user_address_attributes_after_step2] = user_params[:user_address_attributes]
    session[:user_address_attributes_after_step2].merge!(session[:user_address_attributes_after_step1])
    @user = User.new
    @user.build_user_address(session[:user_address_attributes_after_step2])
    render 'devise/registrations/phone' unless session[:user_address_attributes_after_step2][:phone_number].present?
  end

  def address
    session[:user_address_attributes] = user_params[:user_address_attributes]
    @user = User.new(session[:user_params])
    @user.build_user_address
  end

  def complete
  end

  def register
      session[:user_address_attributes] = user_params[:user_address_attributes]
      @user = User.new(session[:user_params])
      @user.build_user_address(session[:user_address_attributes])
    if @user.save(context: :register)
       session[:id] = @user.id
       sns = SnsCredential.update(user_id:  @user.id)
       sign_in User.find(session[:id]) unless user_signed_in?
       redirect_to new_card_path
    else
       render 'devise/registrations/address'
    end
   end

   private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthday,
      user_address_attributes: [:id, :phone_number, :postal_code, :prefecture_id, :address_city, :address_street, :address_building]
      )
   end

    def birthday_join
    date = params[:user]

    if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
      return
    end

    Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
    end
  end