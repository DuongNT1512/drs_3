# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create username: "admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0

manager = User.create username: "manager",
  email: "manager@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1

Position.create! name: "Manager"
Position.create! name: "Employee"
Position.create! name: "Practice"

Division.create! name: "Laboratory"
Division.create! name: "KeangNam"

Progress.create! name: "Read Tutorial"
Progress.create! name: "Project 1"
Progress.create! name: "Project 2"

Language.create! name: "Ruby"

User.create! username: "duong",
  email: "1@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  division_id: "1",
  position_id: "1",
  language_id: "1"

Request.create! user_id: "2",
  request_kind: "in_late",
  reason: "Busy",
  compensation_time_from: Time.zone.now + 10.seconds,
  compensation_time_to: Time.zone.now + 30.seconds,
  date_leave_from: Time.zone.now + 5.seconds,
  date_leave_to: Time.zone.now,
  approved: "approved"
