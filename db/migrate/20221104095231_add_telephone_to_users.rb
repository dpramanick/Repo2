# frozen_string_literal: true

class AddTelephoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telephone, :string
  end
end
