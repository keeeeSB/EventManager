class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :favorite_user, through: :favorites, source: :event
  has_many :reviews, dependent: :destroy
  has_many :reviewer, through: :reviews, source: :user
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  accepts_nested_attributes_for :category, reject_if: :category_blank?

  validates :title, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :start_time, presence: true
  validates :location, presence: true

  private

    def category_blank?(attributes)
      attributes["name"].blank?
    end
end
