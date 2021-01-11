FactoryBot.define do
  factory :user do
    name              {"abe"}
    email { Faker::Internet.email }
    password              {"00000a00"}
    password_confirmation {password}
  end
end
