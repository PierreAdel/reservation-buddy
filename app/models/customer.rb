class Customer < ApplicationRecord
    has_many :reservations
    has_secure_password
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { minimum:2, maximum: 25 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }


end
