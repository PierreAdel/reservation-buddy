class Hotel < ApplicationRecord
    belongs_to :admin
    has_many :reservations

    before_create :slugify

    def slugify
    self.slug = hotel_name.parameterize
    end
    
    # def avg_Score
    #     reviews.average(:score).rount(2).to_f
    # end
end
