class Users::SessionsController < Devise::SessionsController
  include Devise::Controllers::Rememberable
  skip_before_action :verify_authenticity_token
  # prepend_before_action :authenticate_with_two_factor, only: [:create]
  respond_to :json
  # We need to intercept the create action for processing OTP.
  # Unfortunately we can't override `create` because any code that calls `current_user` will
  # automatically log the user in without OTP. To prevent that, we just have to handle it in
  # a before_action instead

  def authenticate_with_two_factor
    self.resource = find_user
    return unless resource
    return unless resource.otp_required_for_login?

    # Submitted email and password, save user ID and send along to OTP
    if sign_in_params[:password] && resource.valid_password?(sign_in_params[:password])
      session[:remember_me] = Devise::TRUE_VALUES.include?(sign_in_params[:remember_me])
      session[:otp_user_id] = resource.id
      render :otp, status: :unprocessable_entity

    # Submitted OTP, so verify and login
    elsif session[:otp_user_id] && params[:otp_attempt]
      if resource.verify_and_consume_otp!(params[:otp_attempt])
        session.delete(:otp_user_id)
        remember_me(resource) if session.delete(:remember_me)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource, event: :authentication)
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        flash.now[:alert] = t(".incorrect_verification_code")
        render :otp, status: :unprocessable_entity
      end
    end
  end

  def find_user
    if session[:otp_user_id]
      resource_class.find(session[:otp_user_id])

    elsif sign_in_params[:email]
      resource_class.find_by(email: sign_in_params[:email])
    end
  end

  private

  def respond_with(resource, _opts = {})
    if current_user
      redirect_to root_path and return
      render json: {
        status: {code: 200, message: "Logged in sucessfully."},
        user: current_user
      }, status: :ok
    end
  end

  # This seems to be handling the verification for the current user, and if current user is verified, the user is logged out. Tested in postman by attaching JWT to request headers and worked correctly.
  def respond_to_on_destroy
    if !current_user
      redirect_to root_path and return
      render json: {
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
