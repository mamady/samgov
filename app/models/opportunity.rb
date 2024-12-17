class Opportunity < ApplicationRecord
  validates :noticeId, presence: true, uniqueness: true
  validates :title, presence: true
  validates :postedDate, presence: true

  belongs_to :naics_code, foreign_key: 'naicsCode', primary_key: 'naics_code', optional: true
end