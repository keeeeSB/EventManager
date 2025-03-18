class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  STATUSES = [ "pending", "approved", "rejected" ]
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :user_id, uniqueness: { scope: :event_id }
end
