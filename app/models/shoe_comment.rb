class ShoeComment < ApplicationRecord

  belongs_to :customer
  belongs_to :shoe

  validates :comment,  presence: true

  # 投稿日絞り込み
  scope :today,     -> { where("created_at >= ?", Date.taday.beginning_of_day) }
  scope :three_day, -> { where("created_at >= ?", 3.day.ago.beginning_of_day) }
  scope :one_week,  -> { where("created_at >= ?", 1.week.ago.beginning_of_day) }
  scope :one_month, -> { where("created_at >= ?", 1.manth.ago.beginning_of_day) }
  scope :one_yesr,  -> { where("created_at >= ?", 1.year.ago.beginning_of_day) }
  
end
