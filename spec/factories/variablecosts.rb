FactoryBot.define do
  factory :variablecost do
    name        {"電気代"}
    year_month  {"2010/06/27"}
    value       {150000}
    description {"オール電化"}
    association :user
  end
end
