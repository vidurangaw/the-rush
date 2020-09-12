# frozen_string_literal: true

FactoryBot.define do
  teams = %w[JAX MIN BAL CLE DAL NO BUF GB KC]
  positions = %w[RB QB WR]

  factory :rushing do
    player { Faker::Name.unique.name }
    team { teams.sample }
    pos { positions.sample }
    att { Faker::Number.number(digits: 2) }
    att_g { Faker::Number.decimal(l_digits: 2) }
    yds { Faker::Number.number(digits: 2) }
    avg { Faker::Number.decimal(l_digits: 2) }
    yds_g { Faker::Number.decimal(l_digits: 2) }
    td { Faker::Number.number(digits: 2) }
    lng { Faker::Number.number(digits: 2) }
    first { Faker::Number.number(digits: 2) }
    first_pct { Faker::Number.decimal(l_digits: 2) }
    twenty_plus { Faker::Number.number(digits: 2)  }
    forty_plus { Faker::Number.number(digits: 2) }
    fum { Faker::Number.number(digits: 2) }
  end
end
