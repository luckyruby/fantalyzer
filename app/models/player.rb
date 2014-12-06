class Player < ActiveRecord::Base
  has_many :games, dependent: :destroy, autosave: true

  validates :yahoo_id, :first_name, :last_name, presence: true
  validates :yahoo_id, uniqueness: true
  validates :last_name, uniqueness: { scope: :first_name }
end
