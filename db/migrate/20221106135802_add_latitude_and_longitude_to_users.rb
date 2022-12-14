# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddLatitudeAndLongitudeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end

# rubocop:enable Style/Documentation
