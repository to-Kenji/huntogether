FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "USER_NAME#{n}" }
    sequence(:email) { |n| "USER_EMAIL#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end