# frozen_string_literal: true

class Rushing < ApplicationRecord
  MAPPINGS = {
    "player": 'Player',
    "team": 'Team',
    "pos": 'Pos',
    "att": 'Att',
    "att_g": 'Att/G',
    "yds": 'Yds',
    "avg": 'Avg',
    "yds_g": 'Yds/G',
    "td": 'TD',
    "lng": 'Lng',
    "1st": '1st',
    "1st_pct": '1st%',
    "20_plus": '20+',
    "40_plus": '40+',
    "fum": 'FUM'
  }.freeze

  before_create :set_lng_int

  private

  def set_lng_int
    self.lng_int = lng.to_i
  end
end
