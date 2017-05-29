class Message < ApplicationRecord

  belongs_to :user, inverse_of: :messages

end
