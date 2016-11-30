User.create!(name:  "admin",
             email: "admin@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             is_admin: true)

User.create!(name:  "Test",
             email: "tester@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             is_admin: false)

