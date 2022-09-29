class StudentsController < ApplicationController
  before_action :set_student, only: %i[show update destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
    User.build(@student)
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.create(student_params)

    if @student.user
      @student.user = User.invite!(email: @student.user.email, name: @student.user.name)
    end
  
    if @student.save
      render :show, status: :created, location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    if @student.update(student_params)
      render :show, status: :ok, location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
    unless @student.user
      User.build(@student)
    end
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:cohort_id, :student_name, :absences, assessments_attributes: [:id, :week, :comprehension, :status, :reviewer, :notes], user_attributes: [:email, :name])
  end
end
