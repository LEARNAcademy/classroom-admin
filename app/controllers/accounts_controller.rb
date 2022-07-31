class AccountsController < Accounts::BaseController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy, :switch]
  before_action :require_account_admin, only: [:edit, :update, :destroy]
  before_action :prevent_personal_account_deletion, only: [:destroy]

  # GET /accounts
  def index
    @pagy, @accounts = pagy(current_user.accounts)
  end

  # GET /accounts/1
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  def create
    @account = Account.new(account_params.merge(owner: current_user))
    @account.account_users.new(user: current_user, admin: true)

    if @account.save
      # Automatically switch to the new account on the next request
      flash[:notice] = t(".created")
      switch
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      redirect_to @account, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
    redirect_to accounts_url, notice: t(".destroyed")
  end

  # Current account will not change until the next request
  def switch
    session[:account_id] = @account.id
    redirect_to root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    attributes = [:name, :avatar]
    params.require(:account).permit(*attributes)
  end

  def prevent_personal_account_deletion
    if @account.personal?
      redirect_to account_path(@account), alert: t(".personal.cannot_delete")
    end
  end
end
