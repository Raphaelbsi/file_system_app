require 'rails_helper'

RSpec.describe Directory, type: :model do
  it 'is valid with a name' do
    directory = Directory.new(name: 'docs')
    expect(directory).to be_valid
  end

  it 'is invalid without a name' do
    directory = Directory.new(name: nil)
    expect(directory).not_to be_valid
  end

  it 'allows nesting as subdirectory' do
    root = Directory.create!(name: 'root')
    child = Directory.new(name: 'child', parent: root)
    expect(child).to be_valid
  end

  it 'does not allow duplicate names under same parent' do
    parent = Directory.create!(name: 'shared')
    Directory.create!(name: 'docs', parent: parent)
    dup = Directory.new(name: 'docs', parent: parent)
    expect(dup).not_to be_valid
  end
end
