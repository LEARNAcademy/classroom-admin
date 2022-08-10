class CohortsController < ApplicationController
  before_action :set_cohort, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /cohorts
  def index
    @pagy, @cohorts = pagy(Cohort.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @cohorts
  end

  # GET /cohorts/1 or /cohorts/1.json
  def show
  end

  # GET /cohorts/new
  def new
    @cohort = Cohort.new

    # Uncomment to authorize with Pundit
    # authorize @cohort
  end

  # GET /cohorts/1/edit
  def edit
  end

  # POST /cohorts or /cohorts.json
  def create
    @cohort = Cohort.new(cohort_params)

    # Uncomment to authorize with Pundit
    # authorize @cohort

    respond_to do |format|
      if @cohort.save
        format.html { redirect_to @cohort, notice: "Cohort was successfully created." }
        format.json { render :show, status: :created, location: @cohort }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cohort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cohorts/1 or /cohorts/1.json
  def update
    respond_to do |format|
      if @cohort.update(cohort_params)
        format.html { redirect_to @cohort, notice: "Cohort was successfully updated." }
        format.json { render :show, status: :ok, location: @cohort }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cohort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cohorts/1 or /cohorts/1.json
  def destroy
    @cohort.destroy
    respond_to do |format|
      format.html { redirect_to cohorts_url, notice: "Cohort was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cohort
    @cohort = Cohort.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @cohort
  rescue ActiveRecord::RecordNotFound
    redirect_to cohorts_path
  end

  # Only allow a list of trusted parameters through.
  def cohort_params
    params.require(:cohort).permit(:cohort_name)

    # Uncomment to use Pundit permitted attributes
    # params.require(:cohort).permit(policy(@cohort).permitted_attributes)
  end
end
