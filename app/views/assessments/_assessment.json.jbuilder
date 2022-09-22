json.extract! assessment, :id, :student_id, :week, :status, :comprehension, :reviewer, :notes, :created_at, :updated_at
json.url assessment_url(assessment, format: :json)
