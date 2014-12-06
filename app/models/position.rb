class Position < ActiveRecord::Base
  has_many :player_positions, dependent: :destroy, autosave: true
  has_many :players, through: :player_positions
  validates :name, presence: true
  validates :name, uniqueness: true
end
