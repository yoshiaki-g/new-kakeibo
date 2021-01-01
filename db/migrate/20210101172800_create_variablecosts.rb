class CreateVariablecosts < ActiveRecord::Migration[6.0]
  def change
    create_table :variablecosts do |t|

      t.timestamps
    end
  end
end
