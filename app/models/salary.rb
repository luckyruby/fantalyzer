class Salary < ActiveRecord::Base
  belongs_to :user
  belongs_to :player

  validates :user, :player, :position, :salary, presence: true

  scope :active, -> {where status: 'active'}
end
