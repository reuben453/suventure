class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  validate :validate_username
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  has_many :messages, inverse_of: :user

  after_create do |user|
    user.messages.add_sign_up_message(user: user)
  end

  attr_accessor :login

  def as_json(options={})
    super(
      options.reverse_merge({
        only: [:username, :email],
        include: {
          messages: {
            only: [:event, :content, :created_at]
          }
        }
      })
    )
  end

  def regenerate_token
    self.authentication_token = Devise.friendly_token
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end


  def after_confirmation
    self.messages.add_email_confirmation_message(user: self)
  end

  Warden::Manager.after_authentication do |user,auth,opts|
    user.messages.add_signin_message(user: user)
  end

  Warden::Manager.before_logout do |user,auth,opts|
    user.messages.add_signout_message(user: user)
  end


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
end
