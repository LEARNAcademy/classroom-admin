class Users::RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: :create
  respond_to :json
  protected

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)

    resource.skip_confirmation!

    # Registering to accept an invitation should display the invitation on sign up
    if params[:invite] && (invite = AccountInvitation.find_by(token: params[:invite]))
      @account_invitation = invite
      resource.skip_default_account = true
    end
  end

  def update_resource(resource, params)
    # Allow user to edit their profile without password
    resource.update_without_password(params)
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)

    # If user registered through an invitation, automatically accept it after signing in
    if @account_invitation
      @account_invitation.accept!(current_user)

      # Clear redirect to account invitation since it's already been accepted
      stored_location_for(:user)
    end
  end
end
