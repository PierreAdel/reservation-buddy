FactoryBot.define do
  factory :reservation do
    date_from { '02-02-2050' }
    customer_id { 1 }
    hotel_id { 1 }
    number_of_days { 9 }
    total_price { 99.99 }
  end
end
