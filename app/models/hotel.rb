class Hotel < ApplicationRecord
    belongs_to :admin
    has_many :reservations

    before_create :slugify
    before_update :slugify

    validates :hotel_name, uniqueness: true, presence: true, length: { minimum: 2 }
    validates :city, presence: true, length: { minimum: 2 }
    validates :cover_image_url, presence: true, length: { minimum: 2 }
    validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
    validates :price_per_night, numericality: { greater_than: 0, less_than_or_equal_to: 10000 }

    def slugify
    self.slug = hotel_name.parameterize
    end
    
    # def avg_Score
    #     reviews.average(:score).rount(2).to_f
    # end
end
