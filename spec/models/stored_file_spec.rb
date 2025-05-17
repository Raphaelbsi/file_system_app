require 'rails_helper'

RSpec.describe StoredFile, type: :model do
  let(:directory) { Directory.create!(name: 'root') }

  it 'is valid with a name and directory' do
    file = StoredFile.new(name: 'file.txt', directory: directory)
    expect(file).to be_valid
  end

  it 'is invalid without a name' do
    file = StoredFile.new(name: nil, directory: directory)
    expect(file).not_to be_valid
  end

  it 'is invalid without a directory' do
    file = StoredFile.new(name: 'file.txt')
    expect(file).not_to be_valid
  end

  it 'does not allow duplicate names in the same directory' do
    StoredFile.create!(name: 'file.txt', directory: directory)
    dup = StoredFile.new(name: 'file.txt', directory: directory)
    expect(dup).not_to be_valid
  end
end
