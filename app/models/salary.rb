class Salary < ActiveRecord::Base
  belongs_to :user
  belongs_to :player

  validates :user, :player, :position, :salary, presence: true
end
