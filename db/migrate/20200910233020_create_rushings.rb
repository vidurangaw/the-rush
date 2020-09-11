class CreateRushings < ActiveRecord::Migration[6.0]
  def change
    create_table :rushings do |t|
      t.string :player, index: true
      t.string :team
      t.string :pos
      t.integer :att
      t.float :att_g
      t.integer :yds, index: true
      t.float :avg
      t.float :yds_g
      t.integer :td, index: true
      t.string :lng
      t.integer :lng_int, index: true
      t.integer :'1st'
      t.float :'1st_pct'
      t.integer :'20_plus'
      t.integer :'40_plus'
      t.integer :fum
    end
  end
end
