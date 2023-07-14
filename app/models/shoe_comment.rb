class ShoeComment < ApplicationRecord

  belongs_to :customer
  belongs_to :shoe

  validates :comment,  presence: true

  # 投稿日絞り込み
  scope :comment_cocreated_at_filters, -> (filter) {
    # 当日
    if filter == "Today"
      where("created_at >= ?", Date.today.beginning_of_day)
    # 3日間
    elsif filter == "ThreeDay"
      where("created_at >= ?", 3.days.ago.beginning_of_day)
    # 1週間
    elsif filter == "OneWeek"
      where("created_at >= ?", 1.week.ago.beginning_of_day)
    # 1ヶ月間
    elsif filter == "OneMonth"
      where("created_at >= ?", 1.month.ago.beginning_of_day)
    # 1年間
    elsif filter == "OneYear"
      where("created_at >= ?", 1.year.ago.beginning_of_day)
    else
      all
    end
  }
end
