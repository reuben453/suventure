class Message < ApplicationRecord

  belongs_to :user, inverse_of: :messages

  EVENT_SIGNUP = "signup"
  EVENT_SIGNIN = "login"
  EVENT_SIGNOUT = "logout"
  EVENT_EMAIL_CONFIRMED = "email_confirmed"
  EVENT_TOKEN_GENERATED = 'token_generated'

  def self.add_message(user:, content:, event:)
    self.create!(user: user, content: content, event: event)
  end

  def self.add_sign_up_message(user:, content: "You have signed up for this app.")
    self.add_message(user: user, content: content, event: EVENT_SIGNUP)
  end

  def self.add_email_confirmation_message(user:, content: "You have confirmed your email #{user.email}")
    self.add_message(user: user, content: content, event: EVENT_EMAIL_CONFIRMED)
  end

  def self.add_signin_message(user:, content: "You have signed in.")
    self.add_message(user: user, content: content, event: EVENT_SIGNIN)
  end

  def self.add_signout_message(user:, content: "You have signed out.")
    self.add_message(user: user, content: content, event: EVENT_SIGNOUT)
  end

  def self.add_token_regeneration_message(user:, content: "You have generated a new token.")
    self.add_message(user: user, content: content, event: EVENT_TOKEN_GENERATED)
  end

end
