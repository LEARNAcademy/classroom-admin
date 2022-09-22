json.extract! student, :id, :cohort_id, :student_name, :absences, :created_at, :updated_at
json.url student_url(student, format: :json)
