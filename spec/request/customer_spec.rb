require 'rails_helper'

RSpec.describe 'Customers API', type: :request do
  describe 'GET /customers' do
    let!(:customer1) { FactoryBot.create(:customer, email: 'test@test.com') }
    let!(:customer2) { FactoryBot.create(:customer, email: 'test2@test.com') }

    describe 'GET /customers not as Admin' do
      it 'Get a customer' do
        get "/api/v1/customers/#{customer1.email}"
        expect(response).to have_http_status(:unauthorized)
      end

      it 'Get all customers' do
        get '/api/v1/customers'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'GET /customers as Admin' do
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
      it 'Get a customer' do
        get "/api/v1/customers/#{customer1.email}"
        expect(response).to have_http_status(:success)
        expect(response_body).to eq(
          {
            'id' => 1,
            'name' => "#{customer1.name}",
            'email' => "#{customer1.email}",
            'reservations' => [],
          },
        )
      end

      it 'Get all customers' do
        get '/api/v1/customers'
        expect(response).to have_http_status(:success)
        expect(response_body).to eq(
          {
            'pages' => 1,
            'page' => 1,
            'data' => [
              {
                'id' => 1,
                'name' => "#{customer1.name}",
                'email' => "#{customer1.email}",
                'reservations' => [],
              },
              {
                'id' => 2,
                'name' => "#{customer2.name}",
                'email' => "#{customer2.email}",
                'reservations' => [],
              },
            ],
          },
        )
      end
    end
  end

  # describe 'POST /customers' do
  #   before do
  #     # FactoryBot.create(:admin, name: "Admin", email: "admin@admin.com", password: "password1" )
  #     # post "/api/v1/sessions/admin_login", params: { email: "admin@admin.com", password:"password1"}
  #   end

  #   it 'Create a customer' do
  #     expect {
  #       post '/api/v1/customers',
  #            params: {
  #              customer: {
  #                name: 'Test',
  #                email: 'test@test.com',
  #                password: 'password1',
  #              },
  #            }
  #     }.to change { Customer.count }.from(0).to(1)

  #     expect(response).to have_http_status(:created)
  #     expect(response_body).to eq(
  #       {
  #         'id' => 1,
  #         'name' => 'Test',
  #         'email' => 'test@test.com',
  #         'reservations' => [],
  #       },
  #     )
  #   end
  # end

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
