class Fixedcost < ApplicationRecord
  belongs_to :user
  INTEGER_LONG_REQUIRED  = { numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 9999999 } }
  validates :value,  INTEGER_LONG_REQUIRED
  with_options presence: true do
    validates :year_month, :name, :value, :user_id
  end
end
