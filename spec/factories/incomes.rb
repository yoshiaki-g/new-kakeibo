FactoryBot.define do
  factory :income do
      name        {"給与"}
      year_month  {"2010/06/20"}
      value       {300000}
      description {"主任"}
      association :user
  end
end
