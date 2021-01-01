class CreateFixedcostValues < ActiveRecord::Migration[6.0]
  def change
    create_table :fixedcost_values do |t|

      t.timestamps
    end
  end
end
