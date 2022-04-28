require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  describe 'User sessions' do
    describe 'User Login /sessions' do
      let!(:customer) { FactoryBot.create(:customer, email: 'test@test.com') }

      it 'wrong post /sessions/user_login' do
        post '/api/v1/sessions/user_login',
             params: {
               email: 'wrong@wrong.com',
               password: 'wrong1',
             }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'success post /sessions/user_login' do
        post '/api/v1/sessions/user_login',
             params: {
               email: 'test@test.com',
               password: 'password1',
             }
        expect(response).to have_http_status(:created)
        expect(response_body).to eq(
          {
            'logged_in' => true,
            'user' => {
              'id' => customer.id,
              'name' => "#{customer.name}",
              'email' => "#{customer.email}",
              'reservations' => [],
            },
          },
        )
      end
    end

    describe 'User is logged in /sessions' do
      let!(:customer) { FactoryBot.create(:customer, email: 'test@test.com') }

      it 'not logged in post /sessions/user_logged_in' do
        get '/api/v1/sessions/user_logged_in'
        expect(response).to have_http_status(:ok)
        expect(response_body).to eq({ 'logged_in' => false })
      end

      it 'logged in post /sessions/user_logged_in' do
        post '/api/v1/sessions/user_login',
             params: {
               email: "#{customer.email}",
               password: 'password1',
             }
        get '/api/v1/sessions/user_logged_in'
        expect(response).to have_http_status(:ok)
        expect(response_body).to eq(
          {
            'logged_in' => true,
            'user' => {
              'id' => customer.id,
              'name' => "#{customer.name}",
              'email' => "#{customer.email}",
              'reservations' => [],
            },
          },
        )
      end
    end

    describe 'User log out /sessions' do
      before do
        customer = FactoryBot.create(:customer, email: 'test@test.com')
        post '/api/v1/sessions/user_login',
             params: {
               email: "#{customer.email}",
               password: 'password1',
             }
      end
      it 'post /sessions/user_logged_in' do
        delete '/api/v1/sessions/user_logout'
        expect(response).to have_http_status(:ok)
        expect(response_body).to eq({ 'logged_out' => true })
      end
    end
  end

  describe 'Admin sessions' do
    describe 'Admin Login /sessions' do
      let!(:admin) { FactoryBot.create(:admin, email: 'admin@admin.com') }

      it 'wrong post /sessions/admin_login' do
        post '/api/v1/sessions/admin_login',
             params: {
               email: 'wrong@wrong.com',
               password: 'wrong1',
             }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'success post /sessions/admin_login' do
        post '/api/v1/sessions/admin_login',
             params: {
               email: "#{admin.email}",
               password: 'password1',
             }
        expect(response).to have_http_status(:created)
        expect(response_body).to eq(
          {
            'logged_in' => true,
            'admin' => {
              'id' => admin.id,
              'name' => "#{admin.name}",
              'email' => "#{admin.email}",
            },
          },
        )
      end
    end

    describe 'Admin is logged in /sessions' do
      let!(:admin) { FactoryBot.create(:admin, email: 'admin@admin.com') }

      it 'not logged in post /sessions/admin_logged_in' do
        get '/api/v1/sessions/admin_logged_in'
        expect(response).to have_http_status(:ok)
        expect(response_body).to eq({ 'logged_in' => false })
      end

      it 'logged in post /sessions/admin_logged_in' do
        post '/api/v1/sessions/admin_login',
             params: {
               email: "#{admin.email}",
               password: 'password1',
             }
        get '/api/v1/sessions/admin_logged_in'
        expect(response).to have_http_status(:ok)
        expect(response_body).to eq(
          {
            'logged_in' => true,
            'admin' => {
              'id' => admin.id,
              'name' => "#{admin.name}",
              'email' => "#{admin.email}",
            },
          },
        )
      end
    end

    describe 'Admin log out /sessions' do
      before do
        admin = FactoryBot.create(:admin, email: 'admin@admin.com')
        post '/api/v1/sessions/admin_login',
             params: {
               email: "#{admin.email}",
               password: 'password1',
             }
      end
      it 'post /sessions/admin_logged_in' do
        delete '/api/v1/sessions/admin_logout'
        expect(response).to have_http_status(:ok)
        expect(response_body).to eq({ 'logged_out' => true })
      end
    end
  end
end
