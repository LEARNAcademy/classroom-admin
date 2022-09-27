class AssessmentsController < ApplicationController
  before_action :set_assessment, only: %i[show update destroy]

  # GET /assessments
  # GET /assessments.json
  def index
    @assessments = Assessment.all
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

    if @assessment.save
      render :show, status: :created, location: @assessment
    else
      render json: @assessment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  def update
    if @assessment.update(assessment_params)
      render :show, status: :ok, location: @assessment
    else
      render json: @assessment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
    @assessment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assessment
    @assessment = Assessment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def assessment_params
    params.require(:assessment).permit(:student_id, :week, :status, :comprehension, :reviewer, :notes)
  end
end
