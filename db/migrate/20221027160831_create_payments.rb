# frozen_string_literal: true

# rubocop:disable Style/Documentation

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.string :stripe_transaction_id

      t.timestamps
    end
  end
end

# rubocop:enable Style/Documentation
