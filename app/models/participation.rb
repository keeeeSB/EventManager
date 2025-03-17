class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :event_id }
end
