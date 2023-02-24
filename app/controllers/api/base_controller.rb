class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  prepend_before_action :authenticate_api_token!
  before_action :authenticate_user!
  private

  def authenticate_api_token!
    if (user = user_from_token)
      sign_in user, store: false
    else
      head :unauthorized
    end
  end
  def authenticate_user!
    puts 'AM I appearing?'
    user = User.find_by(email: params[:email])
    unless user&.valid_password?(params[:password])
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def token_from_header
    request.headers.fetch("Authorization", "").split(" ").last
  end

  def api_token
    @_api_token ||= ApiToken.find_by(token: token_from_header)
  end

  # Only for use within authenticate_api_token! above
  # Use current_user/Current.user or current_account/Current.account within app controllers
  def user_from_token
    if api_token.present?
      api_token.touch(:last_used_at)
      api_token.user
    end
  end
end
