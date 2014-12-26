class Team < ActiveRecord::Base
  has_many :players

  validates :name, :abbreviation, :short_code, :conference, :division, presence: true
end
