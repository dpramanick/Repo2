# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddPostcodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :postcode, :integer
  end
end

# rubocop:enable Style/Documentation
