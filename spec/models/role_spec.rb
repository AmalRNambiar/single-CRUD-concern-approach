# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:role)).to be_valid
  end

  it 'is invalid without name' do
    expect(build(:role, name: nil)).not_to be_valid
  end
end
