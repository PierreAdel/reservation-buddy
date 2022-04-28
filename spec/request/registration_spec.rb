require 'rails_helper'

RSpec.describe 'Registrations API', type: :request do
  describe 'Create /registrations' do
    it 'Create /registrations' do
      expect {
        post '/api/v1/registrations',
             params: {
               name: 'Pierre',
               email: 'test@test.com',
               password: 'password1',
             }
      }.to change { Customer.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'logged_in' => true,
          'user' => {
            'id' => 1,
            'name' => 'Pierre',
            'email' => 'test@test.com',
            'reservations' => [],
          },
        },
      )
    end
  end
end
