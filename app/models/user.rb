class User < ApplicationRecord
  has_secure_password

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :events
  has_and_belongs_to_many :genres #favourite relationship
  validates :email, uniqueness: true
  validates :password, length: {minimum: 8}, on: :create
  validates :password, confirmation: true, on: :create
  validates :password, presence: true, on: :create

end
