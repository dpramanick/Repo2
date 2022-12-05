class AddConditionIdToBproducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :bproducts, :condition, foreign_key: true
  end
end
