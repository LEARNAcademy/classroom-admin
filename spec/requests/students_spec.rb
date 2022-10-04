require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/students", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Student. As you add validations to Student, be sure to
  # adjust the attributes here as well.
  let(:user) { FactoryBot.create(:user) }
  let(:cohort) { FactoryBot.create(:cohort) }
  let(:valid_attributes) {
    {
      cohort_id: cohort.id,
      student_name: "Don",
      absences: 0,
      email: "testStudent@email.com"
    }
  }

  let(:invalid_attributes) {
    {
      cohort_id: nil,
      student_name: nil,
      absences: nil,
      email: nil,
    }
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # StudentsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  before(:each) do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      Student.create! valid_attributes
      get students_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      student = Student.create! valid_attributes
      get student_url(student), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Student" do
        expect {
          post students_url,
            params: {student: valid_attributes}, headers: valid_headers, as: :json
        }.to change(Student, :count).by(1)
      end

      it "renders a JSON response with the new student" do
        post students_url,
          params: {student: valid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Student" do
        expect {
          post students_url,
            params: {student: invalid_attributes}, as: :json
        }.to change(Student, :count).by(0)
      end

      it "renders a JSON response with errors for the new student" do
        post students_url,
          params: {student: invalid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          cohort_id: cohort.id,
          student_name: "Don",
          absences: 1
        }
      }

      it "updates the requested student" do
        student = Student.create! valid_attributes
        patch student_url(student),
          params: {student: new_attributes}, headers: valid_headers, as: :json
        student.reload
        expect(response).to be_successful
      end

      it "renders a JSON response with the student" do
        student = Student.create! valid_attributes
        patch student_url(student),
          params: {student: new_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the student" do
        student = Student.create! valid_attributes
        patch student_url(student),
          params: {student: invalid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested student" do
      student = Student.create! valid_attributes
      expect {
        delete student_url(student), headers: valid_headers, as: :json
      }.to change(Student, :count).by(-1)
    end
  end
end
