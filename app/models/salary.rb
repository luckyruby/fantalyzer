class Salary < ActiveRecord::Base
  belongs_to :user
  belongs_to :player
  has_one :statistic, through: :player

  validates :user, :player, :position, :salary, presence: true

  scope :active, -> {where status: 'active'}
  scope :productive, -> {joins(:statistic).where("statistics.last_5 > 10")}
end
