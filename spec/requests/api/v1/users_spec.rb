require 'rails_helper'

RSpec.describe 'Users API', type: :request do
	let!(:user) { create(:user) }
	let(:user_id) { user.id }

	before { host! "api.taskmanager.dev" }

	describe "get users/:id" do
		before do
			headers = { "Accept" => "application/vnd.taskmanager.v1" }
			get "/users/#{user_id}", params: {}, headers: headers
		end

		context "when users exists" do
			it "returns the user" do
				user_response = JSON.parse(response.body)
				expect(user_response['id']).to eq(user_id)
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

end
