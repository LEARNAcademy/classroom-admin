# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
User.create name: "testAdmin", email: "email@example.com", password: "password", password_confirmation: "password", admin: true, terms_of_service: true
