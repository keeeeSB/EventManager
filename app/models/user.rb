class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  mount_uploader :profile_image, ProfileImageUploader

  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :bio, length: { maximum: 100 }
end
