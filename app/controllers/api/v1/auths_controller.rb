class Api::V1::AuthsController < Api::BaseController
  skip_before_action :authenticate_api_token!, only: [:create]

  # Requires email and password params
  # Turbo Native requests should sign in user with cookie for browser authentication
  # Returns an API token for the user if valid
  def create
    user = User.find_by(email: params[:field][:email])
    current_student = Student.find_by(user_id: user.id)
    student_assessment = Assessment.where(student_id: current_student.id)

    if user&.valid_password?(params[:field][:password])
      if turbo_native_app?
        sign_in_user
        render json: {jwt: current_user.jwt, name: current_user.name, absences: current_student.absences, assessment: student_assessment}
      else
        render json: {jwt: user.jwt, name: user.name, absences: current_student.absences, assessment: student_assessment}
      end
    else
      render json: {error: "Unauthorized"}, status: :unauthorized
    end
  end

  def destroy
    notification_token&.destroy
    sign_out(current_user)
    render json: {}
  end

  private

  def user
    @user ||= User.find_by(email: params[:email])
  end

  def sign_in_user
    user.remember_me = true
    sign_in user
  end

  def token_by_name(name)
    user.api_tokens.find_or_create_by(name: name).token
  end

  def error_message
    keys = User.authentication_keys.join(I18n.translate(:"support.array.words_connector"))
    I18n.t("devise.failure.invalid", authentication_keys: keys)
  end

  def notification_token
    current_user.notification_tokens.find_by(token: params[:notification_token])
  end
end
