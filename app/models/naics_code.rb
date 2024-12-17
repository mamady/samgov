class NaicsCode < ApplicationRecord
  validates :naics_code, presence: true, uniqueness: true
  validates :naics_description, presence: true

  def self.find_by_code(code)
    where('naics_code = ?', code).first
  end
end