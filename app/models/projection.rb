class Projection < ActiveRecord::Base
  belongs_to :player
  belongs_to :user

  delegate :name, :mean, :confidence_interval, :cv, :last_5, to: :player, allow_nil: true

  validates :player, :user, :points, presence: true
  validates :points, numericality: { greater_than_or_equal_to: 0 }
  validates :player_id, uniqueness: { scope: :user_id }
end
