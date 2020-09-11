# frozen_string_literal: true

module Api
  class RushingsController < ApplicationController
    before_action :filter_records, :sort_records

    def index
      @rushings = @rushings.page(params[:page]).per(10)
      render json: { data: @rushings.as_json(except: %i[id lng_int]) }
    end

    def download
      csv_data = DownloadService.generate_csv(@rushings)
      send_data csv_data, filename: "rushings-#{Time.current.to_i}.csv"
    end

    private

    def filter_records
      @rushings = if params[:search_term].present?
                    Rushing.where('player ILIKE ?', "%#{params[:search_term]}%")
                  else
                    Rushing.all
                  end
    end

    def sort_records
      @rushings = if params[:sort_by].present? && params[:sort_direction].present?
                    @rushings.order(params[:sort_by] => params[:sort_direction].to_sym)
                  else
                    @rushings
                  end
    end
  end
end
