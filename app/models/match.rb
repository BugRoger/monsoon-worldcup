class Match < ActiveRecord::Base
  has_one :arena, through: :location
  belongs_to :location
  belongs_to :stage

  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"

  validates :location, :stage, presence: true
end
