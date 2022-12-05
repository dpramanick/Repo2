class AddBproductIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :bproduct_id, :integer
  end
end
