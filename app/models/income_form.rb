class IncomeForm
  include ActiveModel::Model
  attr_accessor :name, :description, :year_month, :value, :description, :income_id

  def save
    Income.create(name: name, description: description)
    IncomeValue.create(year_month: year_month, value: value, description: description, income_id: income.id)
  end
end