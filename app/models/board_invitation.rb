class BoardInvitation < ApplicationRecord
  enum :status, {:sent: 0, accepted: 1, rejejected: 2}
  belongs_to :board
  belongs_to :user

  before_create :generate_token

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, inclusion: { in: statuses.keys }

  private

  def generate_token
    self.token = SecureRandom.hex(8)
  end
end
