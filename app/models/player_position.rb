class PlayerPosition < ActiveRecord::Base
  belongs_to :player
  belongs_to :position

  validates :player_id, uniqueness: { scope: :position_id }
end
