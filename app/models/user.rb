class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  mount_uploader :profile_image, ProfileImageUploader

  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_events, through: :favorites, source: :event
  has_many :reviews, dependent: :destroy
  has_many :review_events, through: :reviews, source: :event

  validates :name, presence: true
  validates :bio, length: { maximum: 100 }
end
