class StoredFile < ApplicationRecord
  belongs_to :directory
  has_one_attached :file

  validates :name, presence: true, uniqueness: { scope: :directory_id }
  validates :directory, presence: true
end
