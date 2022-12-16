require "rails_helper"

RSpec.describe "CurrentUsers", type: :request do
  describe "GET /index" do
    it "redirects with invalid request without JWT" do
      get "/current_user"
      expect(response).to have_http_status(302)
    end

    # it 'responds with JSON with JWT' do
    #   jwt = confirm_and_login_user(current_user)
    #   get '/current_user', headers: { "Authorization" => "Bearer #{jwt}" }
    #   expect(response).to have_http_status(200)
    # end
  end
end
