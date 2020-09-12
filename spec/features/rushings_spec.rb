# frozen_string_literal: true

require 'rails_helper'

feature 'Rushings', js: true do
  let!(:rushings) { create_list(:rushing, 5) }

  scenario 'view no rushings' do
    Rushing.destroy_all
    visit root_path

    expect(page).to have_content('No matching records were found.')
  end

  scenario 'view rushings' do
    visit root_path

    expect(page).to have_content(rushings[0].player)
  end

  scenario 'search rushings' do
    visit root_path

    expect(page).to have_content(rushings[1].player)

    fill_in 'search_term', with: rushings[0].player

    expect(page).to have_content(rushings[0].player)
    expect(page).not_to have_content(rushings[1].player)
  end

  scenario 'view rushings page 2' do
    rushings = create_list(:rushing, 10)
    visit root_path

    expect(page).to have_content(rushings[1].player)

    find('a', text: '2').click

    expect(page).to have_content(rushings[-1].player)
    expect(page).not_to have_content(rushings[0].player)
  end

  scenario 'sort by yds' do
    visit root_path
    find('th', text: 'TD').click

    expect(find('tbody tr', match: :first)).to have_content(rushings.pluck(:td).max)

    find('th', text: 'TD').click

    expect(find('tbody tr', match: :first)).to have_content(rushings.pluck(:td).min)
  end
end
