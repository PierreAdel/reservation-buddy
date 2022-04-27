require 'rails_helper'

RSpec.describe 'Reservations API', type: :request do
  describe 'GET /reservations, get_all_reservations' do
    let!(:admin1) do
      FactoryBot.create(
        :admin,
        name: 'Admin',
        email: 'admin@admin.com',
        password: 'password1',
      )
    end
    let!(:hotel1) do
      FactoryBot.create(:hotel, hotel_name: 'Pierre', admin_id: 1)
    end
    let!(:customer1) { FactoryBot.create(:customer, email: 'test@test.com') }
    let!(:reservation1) { FactoryBot.create(:reservation) }
    let!(:reservation2) { FactoryBot.create(:reservation) }

    describe 'GET /reservations not as Admin' do
      it 'Get all reservations' do
        get '/api/v1/reservations'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'GET /reservations as Admin' do
      before do
        post '/api/v1/sessions/admin_login',
             params: {
               email: 'admin@admin.com',
               password: 'password1',
             }
      end

      it 'Get all reservations' do
        get '/api/v1/reservations'
        expect(response).to have_http_status(:success)
        expect(response_body).to eq(
          {
            'pages' => 1,
            'page' => 1,
            'data' => [
              {
                'id' => 1,
                'date_from' => "#{reservation1.date_from}",
                'number_of_days' => reservation1.number_of_days,
                'total_price' => reservation1.total_price,
                'price_per_night' => reservation1.hotel.price_per_night,
                'customer_id' => reservation1.customer_id,
                'customer_name' => "#{reservation1.customer.name}",
                'hotel_id' => reservation1.hotel_id,
                'hotel_name' => "#{reservation1.hotel.hotel_name}",
                'hotel_description' => "#{reservation1.hotel.description}",
                'cover_image_url' => "#{reservation1.hotel.cover_image_url}",
                'score' => reservation1.hotel.score,
                'hotel_city' => "#{reservation1.hotel.city}",
              },
              {
                'id' => 2,
                'date_from' => "#{reservation2.date_from}",
                'number_of_days' => reservation2.number_of_days,
                'total_price' => reservation2.total_price,
                'price_per_night' => reservation2.hotel.price_per_night,
                'customer_id' => reservation2.customer_id,
                'customer_name' => "#{reservation2.customer.name}",
                'hotel_id' => reservation2.hotel_id,
                'hotel_name' => "#{reservation2.hotel.hotel_name}",
                'hotel_description' => "#{reservation2.hotel.description}",
                'cover_image_url' => "#{reservation2.hotel.cover_image_url}",
                'score' => reservation2.hotel.score,
                'hotel_city' => "#{reservation2.hotel.city}",
              },
            ],
          },
        )
      end
    end
  end

  describe 'GET /reservations/my_reservations, get_all_my_reservations' do
    let!(:admin1) do
      FactoryBot.create(
        :admin,
        name: 'Admin',
        email: 'admin@admin.com',
        password: 'password1',
      )
    end
    let!(:hotel1) do
      FactoryBot.create(:hotel, hotel_name: 'Pierre', admin_id: 1)
    end
    let!(:customer1) { FactoryBot.create(:customer, email: 'test@test.com') }
    let!(:reservation1) { FactoryBot.create(:reservation) }
    let!(:reservation2) { FactoryBot.create(:reservation) }

    describe 'GET /reservations/my_reservations not as User' do
      it 'Get all my_reservations' do
        get '/api/v1/reservations/my_reservations'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'GET /reservations/my_reservations as User' do
      before do
        post '/api/v1/sessions/user_login',
             params: {
               email: "#{customer1.email}",
               password: 'password1',
             }
      end

      it 'Get all my_reservations' do
        get '/api/v1/reservations/my_reservations'
        expect(response).to have_http_status(:success)
        expect(response_body).to eq(
          [
            {
              'id' => 1,
              'date_from' => "#{reservation1.date_from}",
              'number_of_days' => reservation1.number_of_days,
              'total_price' => reservation1.total_price,
              'price_per_night' => reservation1.hotel.price_per_night,
              'customer_id' => reservation1.customer_id,
              'customer_name' => "#{reservation1.customer.name}",
              'hotel_id' => reservation1.hotel_id,
              'hotel_name' => "#{reservation1.hotel.hotel_name}",
              'hotel_description' => "#{reservation1.hotel.description}",
              'cover_image_url' => "#{reservation1.hotel.cover_image_url}",
              'score' => reservation1.hotel.score,
              'hotel_city' => "#{reservation1.hotel.city}",
            },
            {
              'id' => 2,
              'date_from' => "#{reservation2.date_from}",
              'number_of_days' => reservation2.number_of_days,
              'total_price' => reservation2.total_price,
              'price_per_night' => reservation2.hotel.price_per_night,
              'customer_id' => reservation2.customer_id,
              'customer_name' => "#{reservation2.customer.name}",
              'hotel_id' => reservation2.hotel_id,
              'hotel_name' => "#{reservation2.hotel.hotel_name}",
              'hotel_description' => "#{reservation2.hotel.description}",
              'cover_image_url' => "#{reservation2.hotel.cover_image_url}",
              'score' => reservation2.hotel.score,
              'hotel_city' => "#{reservation2.hotel.city}",
            },
          ],
        )
      end
    end
  end

  describe 'POST /reservations' do
    let!(:admin1) do
      FactoryBot.create(
        :admin,
        name: 'Admin',
        email: 'admin@admin.com',
        password: 'password1',
      )
    end
    let!(:hotel1) { FactoryBot.create(:hotel, hotel_name: 'Test', admin_id: 1) }
    let!(:customer1) { FactoryBot.create(:customer, email: 'test@test.com') }

    describe 'Create a reservation not as User' do
      it 'Create a reservation' do
        expect {
          post "/api/v1/reservations/#{hotel1.slug}",
               params: {
                 customer_id: 1,
                 hotel_id: 1,
                 date_from: '2050-02-02',
                 number_of_days: 2,
               }
        }.not_to change { Reservation.count }.from(0)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'Create a reservation as User' do
      before do
        post '/api/v1/sessions/user_login',
             params: {
               email: "#{customer1.email}",
               password: 'password1',
             }
      end
      it 'Create a reservation' do
        expect {
          post "/api/v1/reservations/#{hotel1.slug}",
               params: {
                 customer_id: 1,
                 hotel_id: 1,
                 date_from: '2050-02-02',
                 number_of_days: 2,
               }
        }.to change { Reservation.count }.from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(response_body).to eq(
          {
            'id' => 1,
            'date_from' => '2050-02-02',
            'number_of_days' => 2,
            'total_price' => 2 * 99.99,
            'price_per_night' => 99.99,
            'customer_id' => 1,
            'customer_name' => 'Test',
            'hotel_id' => 1,
            'hotel_name' => 'Test',
            'hotel_description' => "#{hotel1.description}",
            'cover_image_url' => "#{hotel1.cover_image_url}",
            'score' => hotel1.score,
            'hotel_city' => "#{hotel1.city}",
          },
        )
      end
    end
  end

  describe 'DELETE /customers/:email' do
    let!(:customer) { FactoryBot.create(:customer, email: 'test@test.com') }

    describe 'DELETE /customers/:email not as Admin' do
      it 'Delete a customer' do
        expect { delete "/api/v1/customers/#{customer.email}" }.not_to change {
          Customer.count
        }.from(1)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'DELETE /customers/:email as Admin' do
      before do
        FactoryBot.create(
          :admin,
          name: 'Admin',
          email: 'admin@admin.com',
          password: 'password1',
        )
        post '/api/v1/sessions/admin_login',
             params: {
               email: 'admin@admin.com',
               password: 'password1',
             }
      end

      it 'Delete a customer as Admin' do
        expect { delete "/api/v1/customers/#{customer.email}" }.to change {
            Customer.count
          }
          .from(1)
          .to(0)

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
