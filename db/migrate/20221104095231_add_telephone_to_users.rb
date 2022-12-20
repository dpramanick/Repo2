# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddTelephoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telephone, :string
  end
end

# rubocop:enable Style/Documentation
