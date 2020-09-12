# frozen_string_literal: true

require 'rails_helper'

describe 'Rushings' do
  let!(:rushings) { create_list(:rushing, 5) }

  describe 'GET #index' do
    it 'get all rushings' do
      get api_rushings_path

      expect(json_body['data'].length).to eq(5)
    end

    it 'search rushings' do
      player_name = rushings[0].player
      get api_rushings_path(search_term: player_name)

      expect(json_body['data'].length).to eq(1)
      expect(json_body['data'][0]['player']).to eq(player_name)
    end

    it 'sort rushings by td asc order' do
      get api_rushings_path(sort_by: 'td', sort_direction: 'desc')

      expect(json_body['data'][0]['td']).to eq(rushings.pluck(:td).max)
    end

    it 'sort rushings by td desc order' do
      get api_rushings_path(sort_by: 'td', sort_direction: 'asc')

      expect(json_body['data'][0]['td']).to eq(rushings.pluck(:td).min)
    end

    it 'return error when invalid sorting params are used' do
      get api_rushings_path(sort_by: 'cd', sort_direction: 'asc')

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #download' do
    it 'download all rushings' do
      post api_rushings_download_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include rushings[0].player
    end
  end
end
