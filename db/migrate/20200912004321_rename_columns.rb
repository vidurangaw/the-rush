class RenameColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :rushings, '1st', :first
    rename_column :rushings, '1st_pct', :first_pct
    rename_column :rushings, '20_plus', :twenty_plus
    rename_column :rushings, '40_plus', :forty_plus
  end
end