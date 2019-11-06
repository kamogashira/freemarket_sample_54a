class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :sns_credentials
  has_one :user_address
  accepts_nested_attributes_for :user_address
  has_many :credit_cards
  has_many :products
  has_many :comments
  has_one :evaluation
  has_one :user_address
  has_one :delivery_address
  has_one :credit_card

  # validates :nickname,                presence: true, length: {maximum: 20}
  # validates :email,                   presence: true, uniqueness: true
  # validates :password,                presence: true, length: {minimum: 6, maximum: 128}
  # validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,128}+\z/i }
  # validates :last_name,               presence: true
  # validates :first_name,              presence: true
  # validates :last_name_kana,          presence: true
  # validates :first_name_kana,         presence: true
  # validates :birthday,                presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
         def self.find_oauth(auth)
          uid = auth.uid
          provider = auth.provider
          snscredential = SnsCredential.where(uid: uid, provider: provider).first
          if snscredential.present?
            user = User.where(id: snscredential.user_id).first
          else
            user = User.where(email: auth.info.email).first
            if user.present?
              SnsCredential.create(
                uid: uid,
                provider: provider,
                user_id: user.id
                )
            else
              user = User.create(
                nickname: auth.info.name,
                email:    auth.info.email,
                password: Devise.friendly_token[0, 20],
                )
              SnsCredential.create(
                uid: uid,
                provider: provider,
                user_id: user.id
                )
            end
          end
          return user
        end
      end
