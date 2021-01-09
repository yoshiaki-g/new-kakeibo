class CreateFixedcostValues < ActiveRecord::Migration[6.0]
  def change
    create_table :fixedcost_values do |t|
      t.date       :year_month  ,null: false
      t.integer    :value       ,null: false
      t.string     :description
      t.references :fixedcost   ,null: false, foreign_key: true
      t.timestamps
    end
  end
end
