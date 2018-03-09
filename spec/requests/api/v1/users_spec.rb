require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }

  before { host! 'api.taskmanager.test' }

  describe 'GET users/:id' do
    before do
      headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
      get api_v1_user_path(user_id), params: {}, headers: headers
    end

    context 'when users exists' do
      it 'returns the user' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:id]).to eq(user_id)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when users dont exists' do
      let(:user_id) { 100000 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /users' do
    before do
      headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
      post api_v1_users_path, params: {user: user_params }, headers: headers
    end

    context 'when request are valid' do
      let(:user_params) { attributes_for(:user) }

      it 'returns status 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data correct for user' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        byebug
        expect(user_response[:email]).to eq(user_params[:email])
      end
    end

    context 'when request are invalid' do
      let(:user_params) { attributes_for(:user, email: 'teste') }

      it 'returns status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data with errors' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:error)
      end
    end


  end

end
