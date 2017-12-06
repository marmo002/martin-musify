class User < ApplicationRecord
  mount_uploader :avatars, AvatarUploader
  has_secure_password


  has_many :events
  has_and_belongs_to_many :genres #favourite relationship

  validates :email, uniqueness: true
  validates :password, length: {minimum: 8}, on: :create
  validates :password, confirmation: true, on: :create
  validates :password, presence: true, on: :create

end
