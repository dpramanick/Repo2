# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddUidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_id, :string
    add_column :users, :provider, :string
    add_column :users, :avatar_url, :string
  end
end

# rubocop:enable Style/Documentation
