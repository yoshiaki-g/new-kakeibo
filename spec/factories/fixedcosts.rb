FactoryBot.define do
  factory :fixedcost do
    name        {"家賃"}
    year_month  {"2010/06/25"}
    value       {70000}
    description {"大阪"}
    association :user
  end
end
