class Opportunity < ApplicationRecord
  validates :noticeId, presence: true, uniqueness: true
  validates :title, presence: true
  validates :postedDate, presence: true
end