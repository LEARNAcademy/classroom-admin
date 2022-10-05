# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require "faker"

# Examples:
# 2 admin users
2.times do |i|
    User.create( name: "testAdmin#{i+1}", email: "admin#{i+1}@example.com", password: "password", password_confirmation: "password", admin: true, terms_of_service: true)
end

# 3 cohorts
cohort_array = ["Bravo", "Charlie", "Delta"]
3.times do |i|
    Cohort.create(cohort_name: cohort_array[i],  cohort_year: 2023)
end

# 20 Students
cohort_records_array = Cohort.all
cohort_records_array.each do |cohort|
    20.times do
        student = cohort.students.create(cohort_id: cohort.id, student_name: Faker::Name.unique.first_name, email: Faker::Internet.unique.email, absences: 0)
        student.save
    end
end

# Update Charlie assessments
cohort = Cohort.find_by(cohort_name: "Charlie")
all_charlie_students = cohort.students
all_charlie_students.each do |student|
    student.assessments.each do |assessment|
        assessment.update(status: 2, comprehension: 3, reviewer: Faker::Name.unique.first_name, notes: Faker::Lorem.paragraph)
    end
end


    