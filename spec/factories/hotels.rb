FactoryBot.define do
    factory :hotel do
        cover_image_url { "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg" } 
        description { "the best Pierre Hotel" }
        city { "Pierre city"}
        score {2}
        price_per_night {99.9}
    end
end