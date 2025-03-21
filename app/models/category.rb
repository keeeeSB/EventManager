class Category < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { maximum: 10 },
                   uniqueness: true
end
