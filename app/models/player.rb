class Player < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :games, -> { order("game_date desc") }, dependent: :destroy, autosave: true
  has_many :player_positions, dependent: :destroy, autosave: true
  has_many :positions, through: :player_positions

  validates :id, :first_name, :last_name, presence: true
  validates :id, uniqueness: true
  validates :last_name, uniqueness: { scope: :first_name }

  def name
    "#{first_name} #{last_name}"
  end
end
