FactoryBot.define do
  factory :user do
    name { "USER_NAME" }
    email { "USER_EMAIL@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end