class Users::RegistrationsController < Devise::RegistrationsController
  layout 'registrations_application'
  
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

  def index
  end

  def phone
    params[:user][:birthday] = birthday_join
    session[:user_params] = user_params
    @user = User.new
    @user.build_user_address
    if verify_recaptcha
    else
      flash.now[:recaptcha_error] = I18n.t('recaptcha.errors.verification_failed')
      return render action: :new
    end
  end

  def address
    session[:user_address_attributes] = user_params[:user_address_attributes]
    @user = User.new(session[:user_params])
    @user.build_user_address
  end

  def complete
  end

  def create 
      session[:user_address_attributes] = user_params[:user_address_attributes]
      @user = User.new(session[:user_params])
      @user.build_user_address(session[:user_address_attributes])
    if @user.save!
       session[:id] = @user.id
       sns = SnsCredential.update(user_id:  @user.id)
       sign_in User.find(session[:id]) unless user_signed_in?
       redirect_to new_card_path
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