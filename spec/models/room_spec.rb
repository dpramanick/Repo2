# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'should have a unique name' do
    Room.create!(name: 'Foo')
    room = Room.new(name: 'Foo')
    room.should_not be_valid
    room.errors[:name].should include('has already been taken')
  end
end
