# frozen_string_literal: true

module Api
  class RushingsController < ApplicationController
    before_action :filter_records, :sort_records

    def index
      @rushings = @rushings.page(params[:page])
      render json: { rushings: @rushings }
    end

    def download
      csv_data = DownloadService.generate_csv(@rushings)
      send_data csv_data, filename: "rushings-#{Time.current.to_i}.csv"
    end

    private

    def filter_records
      @rushings = if params[:player].present?
                    Rushing.where('player LIKE ?', "%#{params[:player]}%")
                  else
                    Rushing.all
                  end
    end

    def sort_records
      @rushings = if params[:sort_column].present?
                    @rushings.order(params[:sort_column] => (params[:sort_direction] || 'asc').to_sym)
                  else
                    @rushings.order(:player)
                  end
    end
  end
end
