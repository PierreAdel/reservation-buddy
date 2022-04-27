require 'rails_helper'

RSpec.describe 'Hotels API', type: :request do
  describe 'GET /hotels' do
    before do
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
    let!(:hotel2) do
      FactoryBot.create(:hotel, hotel_name: 'Pierre2', admin_id: 1)
    end

    it 'Get a hotel' do
      get "/api/v1/hotels/#{hotel1.slug}"
      expect(response).to have_http_status(:success)
      expect(response_body).to eq(
        {
          'id' => 1,
          'name' => "#{hotel1.hotel_name}",
          'slug' => "#{hotel1.slug}",
          'score' => hotel1.score,
          'price_per_night' => hotel1.price_per_night,
          'cover_image_url' => "#{hotel1.cover_image_url}",
          'description' => "#{hotel1.description}",
          'city' => "#{hotel1.city}",
          'admin_id' => 1,
          'admin_name' => 'Admin',
        },
      )
    end

    it 'Get all hotels' do
      get '/api/v1/hotels'
      expect(response).to have_http_status(:success)
      expect(response_body).to eq(
        {
          'pages' => 1,
          'page' => 1,
          'data' => [
            {
              'id' => 1,
              'name' => "#{hotel1.hotel_name}",
              'slug' => "#{hotel1.slug}",
              'score' => hotel1.score,
              'price_per_night' => hotel1.price_per_night,
              'cover_image_url' => "#{hotel1.cover_image_url}",
              'description' => "#{hotel1.description}",
              'city' => "#{hotel1.city}",
              'admin_id' => 1,
              'admin_name' => 'Admin',
            },
            {
              'id' => 2,
              'name' => "#{hotel2.hotel_name}",
              'slug' => "#{hotel2.slug}",
              'score' => hotel2.score,
              'price_per_night' => hotel2.price_per_night,
              'cover_image_url' => "#{hotel2.cover_image_url}",
              'description' => "#{hotel2.description}",
              'city' => "#{hotel2.city}",
              'admin_id' => 1,
              'admin_name' => 'Admin',
            },
          ],
        },
      )
    end
  end

  describe 'POST /hotels' do
    describe 'POST /hotels not as Admin' do
      it 'Create hotel' do
        expect {
          post '/api/v1/hotels',
               params: {
                 hotel: {
                   cover_image_url:
                     'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                   hotel_name: 'Pierre',
                   description: 'the best Pierre Hotel',
                   city: 'Pierre city',
                   score: 2,
                   price_per_night: 99.9,
                 },
               }
        }.not_to change { Hotel.count }.from(0)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'POST /hotels as Admin' do
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
      it 'Create hotel' do
        expect {
          post '/api/v1/hotels',
               params: {
                 hotel: {
                   cover_image_url:
                     'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                   hotel_name: 'Pierre',
                   description: 'the best Pierre Hotel',
                   city: 'Pierre city',
                   score: 2,
                   price_per_night: 99.9,
                 },
               }
        }.to change { Hotel.count }.from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(response_body).to eq(
          {
            'id' => 1,
            'name' => 'Pierre',
            'slug' => 'pierre',
            'score' => 2,
            'price_per_night' => 99.9,
            'cover_image_url' =>
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
            'description' => 'the best Pierre Hotel',
            'city' => 'Pierre city',
            'admin_id' => 1,
            'admin_name' => 'Admin',
          },
        )
      end
    end
  end

  describe 'DELETE /hotels/:slug' do
    before do
      FactoryBot.create(
        :admin,
        name: 'Admin',
        email: 'admin@admin.com',
        password: 'password1',
      )
    end
    describe 'DELETE /hotels/:slug not as Admin' do
      let!(:hotel) do
        FactoryBot.create(
          :hotel,
          cover_image_url:
            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
          hotel_name: 'eassazzss',
          description: 'the best Pierre Hotel',
          city: 'Pierre city',
          score: 2,
          price_per_night: 99.9,
          admin_id: 1,
        )
      end

      it 'Delete a hotel' do
        expect { delete "/api/v1/hotels/#{hotel.slug}" }.not_to change {
          Hotel.count
        }.from(1)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'DELETE /hotels/:slug as Admin' do
      describe 'DELETE /hotels/:slug' do
        before do
          post '/api/v1/sessions/admin_login',
               params: {
                 email: 'admin@admin.com',
                 password: 'password1',
               }
        end
        let!(:hotel) do
          FactoryBot.create(
            :hotel,
            cover_image_url:
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
            hotel_name: 'eassazzss',
            description: 'the best Pierre Hotel',
            city: 'Pierre city',
            score: 2,
            price_per_night: 99.9,
            admin_id: 1,
          )
        end

        it 'Delete a hotel' do
          expect { delete "/api/v1/hotels/#{hotel.slug}" }.to change {
              Hotel.count
            }
            .from(1)
            .to(0)

          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end
end
